require 'rails_helper'

RSpec.describe "revenues/new", type: :view do
  before(:each) do
    assign(:revenue, Revenue.new())
  end

  it "renders new revenue form" do
    render

    assert_select "form[action=?][method=?]", revenues_path, "post" do
    end
  end
end
