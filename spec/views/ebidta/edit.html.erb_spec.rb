require 'rails_helper'

RSpec.describe "ebidta/edit", type: :view do
  before(:each) do
    @ebidtum = assign(:ebidtum, Ebidtum.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit ebidtum form" do
    render

    assert_select "form[action=?][method=?]", ebidtum_path(@ebidtum), "post" do

      assert_select "input#ebidtum_name[name=?]", "ebidtum[name]"
    end
  end
end
