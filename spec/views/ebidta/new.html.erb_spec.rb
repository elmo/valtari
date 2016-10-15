require 'rails_helper'

RSpec.describe "ebidta/new", type: :view do
  before(:each) do
    assign(:ebidtum, Ebidtum.new(
      :name => "MyString"
    ))
  end

  it "renders new ebidtum form" do
    render

    assert_select "form[action=?][method=?]", ebidta_path, "post" do

      assert_select "input#ebidtum_name[name=?]", "ebidtum[name]"
    end
  end
end
