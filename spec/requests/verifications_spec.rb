require 'rails_helper'

RSpec.describe "Verifications", type: :request do
  describe "GET /verifications" do
    it "works! (now write some real specs)" do
      get verifications_path
      expect(response).to have_http_status(200)
    end
  end
end
