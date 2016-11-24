require 'rails_helper'

RSpec.describe "Geos", type: :request do
  describe "GET /geos" do
    it "works! (now write some real specs)" do
      get geos_path
      expect(response).to have_http_status(200)
    end
  end
end
