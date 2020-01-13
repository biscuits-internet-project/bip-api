require "rails_helper"

RSpec.describe BandsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/api/bands").to route_to("bands#index", format: :json)
    end

    it "routes to #show" do
      expect(:get => "/api/bands/1").to route_to("bands#show", id: "1", format: :json)
    end


    it "routes to #create" do
      expect(:post => "/api/bands").to route_to("bands#create", format: :json)
    end

    it "routes to #update via PUT" do
      expect(:put => "/api/bands/1").to route_to("bands#update", id: "1", format: :json)
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/api/bands/1").to route_to("bands#update", id: "1", format: :json)
    end

    it "routes to #destroy" do
      expect(:delete => "/api/bands/1").to route_to("bands#destroy", id: "1", format: :json)
    end
  end
end
