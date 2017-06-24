require 'rails_helper'

RSpec.describe "private/deal_rooms/new", type: :view do
  before(:each) do
    assign(:private_deal_room, Private::DealRoom.new())
  end

  it "renders new private_deal_room form" do
    render

    assert_select "form[action=?][method=?]", private_deal_rooms_path, "post" do
    end
  end
end
