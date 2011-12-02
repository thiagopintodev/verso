require 'spec_helper'

describe "degrees/new.html.erb" do
  before(:each) do
    assign(:degree, stub_model(Degree,
      :nome => "MyString"
    ).as_new_record)
  end

  it "renders new degree form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => degrees_path, :method => "post" do
      assert_select "input#degree_nome", :name => "degree[nome]"
    end
  end
end
