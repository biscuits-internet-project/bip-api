require "rails_helper"

RSpec.describe TracksController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/api/tracks").to route_to("tracks#index", format: :json)
    end

    it "routes to #show" do
      expect(:get => "/api/tracks/1").to route_to("tracks#show", id: "1", format: :json)
    end


    it "routes to #create" do
      expect(:post => "/api/tracks").to route_to("tracks#create", format: :json)
    end

    it "routes to #update via PUT" do
      expect(:put => "/api/tracks/1").to route_to("tracks#update", id: "1", format: :json)
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/api/tracks/1").to route_to("tracks#update", id: "1", format: :json)
    end

    it "routes to #destroy" do
      expect(:delete => "/api/tracks/1").to route_to("tracks#destroy", id: "1", format: :json)
    end
  end
end
