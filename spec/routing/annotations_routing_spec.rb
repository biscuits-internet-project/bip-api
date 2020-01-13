require "rails_helper"

RSpec.describe AnnotationsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/api/annotations").to route_to("annotations#index", format: :json)
    end

    it "routes to #show" do
      expect(:get => "/api/annotations/1").to route_to("annotations#show", id: "1", format: :json)
    end


    it "routes to #create" do
      expect(:post => "/api/annotations").to route_to("annotations#create", format: :json)
    end

    it "routes to #update via PUT" do
      expect(:put => "/api/annotations/1").to route_to("annotations#update", id: "1", format: :json)
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/api/annotations/1").to route_to("annotations#update", id: "1", format: :json)
    end

    it "routes to #destroy" do
      expect(:delete => "/api/annotations/1").to route_to("annotations#destroy", id: "1", format: :json)
    end
  end
end
