require "spec_helper"

describe DegreesController do
  describe "routing" do

    it "routes to #index" do
      get("/degrees").should route_to("degrees#index")
    end

    it "routes to #new" do
      get("/degrees/new").should route_to("degrees#new")
    end

    it "routes to #show" do
      get("/degrees/1").should route_to("degrees#show", :id => "1")
    end

    it "routes to #edit" do
      get("/degrees/1/edit").should route_to("degrees#edit", :id => "1")
    end

    it "routes to #create" do
      post("/degrees").should route_to("degrees#create")
    end

    it "routes to #update" do
      put("/degrees/1").should route_to("degrees#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/degrees/1").should route_to("degrees#destroy", :id => "1")
    end

  end
end
