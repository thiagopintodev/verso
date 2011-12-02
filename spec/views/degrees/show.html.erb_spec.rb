require 'spec_helper'

describe "degrees/show.html.erb" do
  before(:each) do
    @degree = assign(:degree, stub_model(Degree,
      :nome => "Nome"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Nome/)
  end
end
