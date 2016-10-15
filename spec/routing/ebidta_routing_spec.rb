require "rails_helper"

RSpec.describe EbidtaController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/ebidta").to route_to("ebidta#index")
    end

    it "routes to #new" do
      expect(:get => "/ebidta/new").to route_to("ebidta#new")
    end

    it "routes to #show" do
      expect(:get => "/ebidta/1").to route_to("ebidta#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/ebidta/1/edit").to route_to("ebidta#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/ebidta").to route_to("ebidta#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/ebidta/1").to route_to("ebidta#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/ebidta/1").to route_to("ebidta#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/ebidta/1").to route_to("ebidta#destroy", :id => "1")
    end

  end
end
