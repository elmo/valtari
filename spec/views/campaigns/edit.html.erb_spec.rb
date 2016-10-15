require 'rails_helper'

RSpec.describe "campaigns/edit", type: :view do
  before(:each) do
    @campaign = assign(:campaign, Campaign.create!(
      :title => "MyString",
      :revenue => 1,
      :ebitda => 1,
      :industry_id => 1
    ))
  end

  it "renders the edit campaign form" do
    render

    assert_select "form[action=?][method=?]", campaign_path(@campaign), "post" do

      assert_select "input#campaign_title[name=?]", "campaign[title]"

      assert_select "input#campaign_revenue[name=?]", "campaign[revenue]"

      assert_select "input#campaign_ebitda[name=?]", "campaign[ebitda]"

      assert_select "input#campaign_industry_id[name=?]", "campaign[industry_id]"
    end
  end
end
