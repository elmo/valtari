require 'rails_helper'

RSpec.describe "geos/show", type: :view do
  before(:each) do
    @geo = assign(:geo, Geo.create!(
      :glogal_region => "Glogal Region",
      :continent => "Continent",
      :country => "Country",
      :region => "Region",
      :subregion => "Subregion"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Glogal Region/)
    expect(rendered).to match(/Continent/)
    expect(rendered).to match(/Country/)
    expect(rendered).to match(/Region/)
    expect(rendered).to match(/Subregion/)
  end
end
