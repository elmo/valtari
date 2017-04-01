require 'rails_helper'

RSpec.describe "verifications/show", type: :view do
  before(:each) do
    @verification = assign(:verification, Verification.create!(
      :integer => "",
      :assigned_to => 2,
      :business_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
