require 'rails_helper'

RSpec.describe "company_types/edit", type: :view do
  before(:each) do
    @company_type = assign(:company_type, CompanyType.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit company_type form" do
    render

    assert_select "form[action=?][method=?]", company_type_path(@company_type), "post" do

      assert_select "input#company_type_name[name=?]", "company_type[name]"
    end
  end
end
