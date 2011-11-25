require "spec_helper"

describe SiteController do
  describe "routing" do

    it "routes to #sobre" do
      get("/sobre").should route_to("site#sobre")
    end

    it "routes to #historico" do
      get("/historico").should route_to("site#historico")
    end

  end
end
