require 'rails_helper'

RSpec.describe "company_types/show", type: :view do
  before(:each) do
    @company_type = assign(:company_type, CompanyType.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
