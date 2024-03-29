require 'spec_helper'

describe "projects/index.html.erb" do
  before(:each) do
    Fabricate(:project)
    Fabricate(:project, :numero=>2)
    assign(:projects, Project.scoped.page(0))
    Fabricate(:subject)
    Fabricate(:degree)
    template.should_receive(:current_user).and_return Fabricate(:user)
  end

  it "renders a list of projects" do
    render
    assert_select "ul#gallery>li", :count => 2
  end
end
