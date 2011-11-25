require 'spec_helper'

describe SiteController do

  describe "GET 'sobre'" do
    it "returns http success" do
      get 'sobre'
      response.should be_success
    end
  end

  describe "GET 'historico'" do
    it "returns http success" do
      get 'historico'
      response.should be_success
    end
  end

end
