require "rails_helper"

RSpec.describe ShowsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/api/shows").to route_to("shows#index", format: :json)
    end

    it "routes to #show" do
      expect(:get => "/api/shows/1").to route_to("shows#show", id: "1", format: :json)
    end


    it "routes to #create" do
      expect(:post => "/api/shows").to route_to("shows#create", format: :json)
    end

    it "routes to #update via PUT" do
      expect(:put => "/api/shows/1").to route_to("shows#update", id: "1", format: :json)
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/api/shows/1").to route_to("shows#update", id: "1", format: :json)
    end

    it "routes to #destroy" do
      expect(:delete => "/api/shows/1").to route_to("shows#destroy", id: "1", format: :json)
    end
  end
end
