require 'spec_helper'

describe "projects/show.html.erb" do
  before(:each) do
    @user = Fabricate(:user)
    @subject = Fabricate(:subject)
    @degree = Fabricate(:degree)
    @project = assign(:project, stub_model(Project,
      :user_id => @user.id,
      :subject_id => @subject.id,
      :degree_id => @degree.id,
      :numero => 1
    ))
    2.times { view.should_receive(:current_user).and_return @user }
    #
    @project_version  = ProjectVersion.new :project => @project
  end
  
  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    #rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(@degree.nome)
    rendered.should match(@subject.nome)
  end
end
