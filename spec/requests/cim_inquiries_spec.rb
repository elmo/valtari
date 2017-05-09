require 'rails_helper'

RSpec.describe "CimInquiries", type: :request do
  describe "GET /cim_inquiries" do
    it "works! (now write some real specs)" do
      get cim_inquiries_path
      expect(response).to have_http_status(200)
    end
  end
end
