require 'spec_helper'

describe "degrees/edit.html.erb" do
  before(:each) do
    @degree = assign(:degree, stub_model(Degree,
      :nome => "MyString"
    ))
  end

  it "renders the edit degree form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => degrees_path(@degree), :method => "post" do
      assert_select "input#degree_nome", :name => "degree[nome]"
    end
  end
end
