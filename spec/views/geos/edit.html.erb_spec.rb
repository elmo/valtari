require 'rails_helper'

RSpec.describe "geos/edit", type: :view do
  before(:each) do
    @geo = assign(:geo, Geo.create!(
      :glogal_region => "MyString",
      :continent => "MyString",
      :country => "MyString",
      :region => "MyString",
      :subregion => "MyString"
    ))
  end

  it "renders the edit geo form" do
    render

    assert_select "form[action=?][method=?]", geo_path(@geo), "post" do

      assert_select "input#geo_glogal_region[name=?]", "geo[glogal_region]"

      assert_select "input#geo_continent[name=?]", "geo[continent]"

      assert_select "input#geo_country[name=?]", "geo[country]"

      assert_select "input#geo_region[name=?]", "geo[region]"

      assert_select "input#geo_subregion[name=?]", "geo[subregion]"
    end
  end
end
