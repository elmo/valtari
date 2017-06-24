require "rails_helper"

RSpec.describe Private::DealRoomsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/private/deal_rooms").to route_to("private/deal_rooms#index")
    end

    it "routes to #new" do
      expect(:get => "/private/deal_rooms/new").to route_to("private/deal_rooms#new")
    end

    it "routes to #show" do
      expect(:get => "/private/deal_rooms/1").to route_to("private/deal_rooms#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/private/deal_rooms/1/edit").to route_to("private/deal_rooms#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/private/deal_rooms").to route_to("private/deal_rooms#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/private/deal_rooms/1").to route_to("private/deal_rooms#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/private/deal_rooms/1").to route_to("private/deal_rooms#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/private/deal_rooms/1").to route_to("private/deal_rooms#destroy", :id => "1")
    end

  end
end
