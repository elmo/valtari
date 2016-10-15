require 'rails_helper'

RSpec.describe "campaigns/show", type: :view do
  before(:each) do
    @campaign = assign(:campaign, Campaign.create!(
      :title => "Title",
      :revenue => 2,
      :ebitda => 3,
      :industry_id => 4
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
  end
end
