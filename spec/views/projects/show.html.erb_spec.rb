require 'spec_helper'

describe "projects/show.html.erb" do
  before(:each) do
    @project = assign(:project, stub_model(Project,
      :user_id => 1,
      :subject_id => 1,
      :degree_id => 1,
      :numero => 1
    ))
    @subject = Fabricate(:subject)
    @degree = Fabricate(:degree)
    #
    @project_version  = ProjectVersion.new :project => @project
  end
  
  def current_user
    Fabricate(:user)
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    #rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    #rendered.should match(@degree.nome)
  end
end
