require 'spec_helper'

describe "reviews/index.html.erb" do
  before(:each) do
    assign(:reviews, [
      stub_model(Review,
        :project => nil,
        :criou_user_id => 1,
        :criou_texto => "MyText",
        :corrigiu_user_id => 1,
        :corrigiu_texto => "MyText",
        :revisou_user_id => 1,
        :revisou_texto => "MyText"
      ),
      stub_model(Review,
        :project => nil,
        :criou_user_id => 1,
        :criou_texto => "MyText",
        :corrigiu_user_id => 1,
        :corrigiu_texto => "MyText",
        :revisou_user_id => 1,
        :revisou_texto => "MyText"
      )
    ])
  end

  it "renders a list of reviews" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
