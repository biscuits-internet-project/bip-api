require "rails_helper"

RSpec.describe SongsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/api/songs").to route_to("songs#index", format: :json)
    end

    it "routes to #show" do
      expect(:get => "/api/songs/1").to route_to("songs#show", id: "1", format: :json)
    end


    it "routes to #create" do
      expect(:post => "/api/songs").to route_to("songs#create", format: :json)
    end

    it "routes to #update via PUT" do
      expect(:put => "/api/songs/1").to route_to("songs#update", id: "1", format: :json)
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/api/songs/1").to route_to("songs#update", id: "1", format: :json)
    end

    it "routes to #destroy" do
      expect(:delete => "/api/songs/1").to route_to("songs#destroy", id: "1", format: :json)
    end
  end
end
