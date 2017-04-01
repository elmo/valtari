require 'rails_helper'

RSpec.describe "verifications/edit", type: :view do
  before(:each) do
    @verification = assign(:verification, Verification.create!(
      :integer => "",
      :assigned_to => 1,
      :business_id => 1
    ))
  end

  it "renders the edit verification form" do
    render

    assert_select "form[action=?][method=?]", verification_path(@verification), "post" do

      assert_select "input#verification_integer[name=?]", "verification[integer]"

      assert_select "input#verification_assigned_to[name=?]", "verification[assigned_to]"

      assert_select "input#verification_business_id[name=?]", "verification[business_id]"
    end
  end
end
