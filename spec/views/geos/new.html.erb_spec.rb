require 'rails_helper'

RSpec.describe "geos/new", type: :view do
  before(:each) do
    assign(:geo, Geo.new(
      :glogal_region => "MyString",
      :continent => "MyString",
      :country => "MyString",
      :region => "MyString",
      :subregion => "MyString"
    ))
  end

  it "renders new geo form" do
    render

    assert_select "form[action=?][method=?]", geos_path, "post" do

      assert_select "input#geo_glogal_region[name=?]", "geo[glogal_region]"

      assert_select "input#geo_continent[name=?]", "geo[continent]"

      assert_select "input#geo_country[name=?]", "geo[country]"

      assert_select "input#geo_region[name=?]", "geo[region]"

      assert_select "input#geo_subregion[name=?]", "geo[subregion]"
    end
  end
end
