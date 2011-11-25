require 'spec_helper'

describe "Site" do
  
  describe "GET /historico" do
    it "renderiza" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get historico_path
      response.status.should be(200)
    end
  end
  
  describe "GET /sobre" do
    it "renderiza" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get sobre_path
      response.status.should be(200)
    end
  end
  
end
