require 'rails_helper'

RSpec.describe "revenues/edit", type: :view do
  before(:each) do
    @revenue = assign(:revenue, Revenue.create!())
  end

  it "renders the edit revenue form" do
    render

    assert_select "form[action=?][method=?]", revenue_path(@revenue), "post" do
    end
  end
end
