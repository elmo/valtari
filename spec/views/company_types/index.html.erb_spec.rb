require 'rails_helper'

RSpec.describe "company_types/index", type: :view do
  before(:each) do
    assign(:company_types, [
      CompanyType.create!(
        :name => "Name"
      ),
      CompanyType.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of company_types" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
