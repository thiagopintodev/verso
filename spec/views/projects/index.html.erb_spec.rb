require 'spec_helper'

describe "projects/index.html.erb" do
  before(:each) do
    assign(:projects, [
      Fabricate(:project),
      Fabricate(:project, :numero=>2)
    ])
    Fabricate(:subject)
    Fabricate(:degree)
  end

  it "renders a list of projects" do
    render
    assert_select "ul.work>li", :count => 2
  end
end
