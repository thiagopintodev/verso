require 'spec_helper'

describe "degrees/index.html.erb" do
  before(:each) do
    assign(:degrees, [
      stub_model(Degree,
        :nome => "Nome"
      ),
      stub_model(Degree,
        :nome => "Nome"
      )
    ])
  end

  it "renders a list of degrees" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nome".to_s, :count => 2
  end
end
