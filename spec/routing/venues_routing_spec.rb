require "rails_helper"

RSpec.describe VenuesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/api/venues").to route_to("venues#index", format: :json)
    end

    it "routes to #show" do
      expect(:get => "/api/venues/1").to route_to("venues#show", id: "1", format: :json)
    end


    it "routes to #create" do
      expect(:post => "/api/venues").to route_to("venues#create", format: :json)
    end

    it "routes to #update via PUT" do
      expect(:put => "/api/venues/1").to route_to("venues#update", id: "1", format: :json)
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/api/venues/1").to route_to("venues#update", id: "1", format: :json)
    end

    it "routes to #destroy" do
      expect(:delete => "/api/venues/1").to route_to("venues#destroy", id: "1", format: :json)
    end
  end
end
