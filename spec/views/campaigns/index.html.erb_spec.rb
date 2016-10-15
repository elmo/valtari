require 'rails_helper'

RSpec.describe "campaigns/index", type: :view do
  before(:each) do
    assign(:campaigns, [
      Campaign.create!(
        :title => "Title",
        :revenue => 2,
        :ebitda => 3,
        :industry_id => 4
      ),
      Campaign.create!(
        :title => "Title",
        :revenue => 2,
        :ebitda => 3,
        :industry_id => 4
      )
    ])
  end

  it "renders a list of campaigns" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
  end
end
