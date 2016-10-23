require 'rails_helper'

RSpec.describe "CompanyTypes", type: :request do
  describe "GET /company_types" do
    it "works! (now write some real specs)" do
      get company_types_path
      expect(response).to have_http_status(200)
    end
  end
end
