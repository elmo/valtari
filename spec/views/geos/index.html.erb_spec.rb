require 'rails_helper'

RSpec.describe "geos/index", type: :view do
  before(:each) do
    assign(:geos, [
      Geo.create!(
        :glogal_region => "Glogal Region",
        :continent => "Continent",
        :country => "Country",
        :region => "Region",
        :subregion => "Subregion"
      ),
      Geo.create!(
        :glogal_region => "Glogal Region",
        :continent => "Continent",
        :country => "Country",
        :region => "Region",
        :subregion => "Subregion"
      )
    ])
  end

  it "renders a list of geos" do
    render
    assert_select "tr>td", :text => "Glogal Region".to_s, :count => 2
    assert_select "tr>td", :text => "Continent".to_s, :count => 2
    assert_select "tr>td", :text => "Country".to_s, :count => 2
    assert_select "tr>td", :text => "Region".to_s, :count => 2
    assert_select "tr>td", :text => "Subregion".to_s, :count => 2
  end
end
