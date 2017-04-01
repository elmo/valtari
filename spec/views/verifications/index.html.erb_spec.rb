require 'rails_helper'

RSpec.describe "verifications/index", type: :view do
  before(:each) do
    assign(:verifications, [
      Verification.create!(
        :integer => "",
        :assigned_to => 2,
        :business_id => 3
      ),
      Verification.create!(
        :integer => "",
        :assigned_to => 2,
        :business_id => 3
      )
    ])
  end

  it "renders a list of verifications" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
