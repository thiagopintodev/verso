require 'spec_helper'

describe "projects/new.html.erb" do
  before(:each) do
    assign(:project, stub_model(Project,
      :user_id => 1,
      :subject_id => 1,
      :degree_id => 1,
      :numero => 1
    ).as_new_record)
  end
  
  def current_user
    Fabricate(:user)
  end

  it "renders new project form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => projects_path, :method => "post" do
      #assert_select "input#project_user_id", :name => "project[user_id]"
      assert_select "select#project_subject_id", :name => "project[subject_id]"
      assert_select "select#project_degree_id", :name => "project[degree_id]"
      assert_select "select#project_numero", :name => "project[numero]"
    end
  end
end
