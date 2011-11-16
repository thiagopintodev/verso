require 'spec_helper'

describe "reviews/new.html.erb" do
  before(:each) do
    assign(:review, stub_model(Review,
      :project => nil,
      :criou_user_id => 1,
      :criou_texto => "MyText",
      :corrigiu_user_id => 1,
      :corrigiu_texto => "MyText",
      :revisou_user_id => 1,
      :revisou_texto => "MyText"
    ).as_new_record)
  end

  it "renders new review form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => reviews_path, :method => "post" do
      assert_select "input#review_project", :name => "review[project]"
      assert_select "input#review_criou_user_id", :name => "review[criou_user_id]"
      assert_select "textarea#review_criou_texto", :name => "review[criou_texto]"
      assert_select "input#review_corrigiu_user_id", :name => "review[corrigiu_user_id]"
      assert_select "textarea#review_corrigiu_texto", :name => "review[corrigiu_texto]"
      assert_select "input#review_revisou_user_id", :name => "review[revisou_user_id]"
      assert_select "textarea#review_revisou_texto", :name => "review[revisou_texto]"
    end
  end
end
