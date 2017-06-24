require 'rails_helper'

RSpec.describe "Private::DealRooms", type: :request do
  describe "GET /private_deal_rooms" do
    it "works! (now write some real specs)" do
      get private_deal_rooms_path
      expect(response).to have_http_status(200)
    end
  end
end
