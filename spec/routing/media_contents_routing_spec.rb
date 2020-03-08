require "rails_helper"

RSpec.describe MediaContentsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/media_contents").to route_to("media_contents#index")
    end

    it "routes to #show" do
      expect(:get => "/media_contents/1").to route_to("media_contents#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/media_contents").to route_to("media_contents#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/media_contents/1").to route_to("media_contents#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/media_contents/1").to route_to("media_contents#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/media_contents/1").to route_to("media_contents#destroy", :id => "1")
    end
  end
end
