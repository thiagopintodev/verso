require 'spec_helper'

describe "projects/edit.html.erb" do
  before(:each) do
    @project = assign(:project, stub_model(Project,
      :user_id => 1,
      :subject_id => 1,
      :degree_id => 1,
      :numero => 1,
      :status_revisao_texto => 1,
      :status_revisao_final => 1,
      :status_revisao_audio => 1,
      :status_producao => 1
    ))
  end

  it "renders the edit project form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => projects_path(@project), :method => "post" do
      assert_select "input#project_user_id", :name => "project[user_id]"
      assert_select "input#project_subject_id", :name => "project[subject_id]"
      assert_select "input#project_degree_id", :name => "project[degree_id]"
      assert_select "input#project_numero", :name => "project[numero]"
      assert_select "input#project_status_revisao_texto", :name => "project[status_revisao_texto]"
      assert_select "input#project_status_revisao_final", :name => "project[status_revisao_final]"
      assert_select "input#project_status_revisao_audio", :name => "project[status_revisao_audio]"
      assert_select "input#project_status_producao", :name => "project[status_producao]"
    end
  end
end
