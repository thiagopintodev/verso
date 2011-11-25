require 'spec_helper'

describe "Projects" do
  
  describe "GET /aulas" do
    it "area restrita, redireciona pois necessita login" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get projects_path
      #response.status.should be(200)
      response.status.should be(302)
    end
  end
end
