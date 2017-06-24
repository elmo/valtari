require 'rails_helper'

RSpec.describe "private/deal_rooms/edit", type: :view do
  before(:each) do
    @private_deal_room = assign(:private_deal_room, Private::DealRoom.create!())
  end

  it "renders the edit private_deal_room form" do
    render

    assert_select "form[action=?][method=?]", private_deal_room_path(@private_deal_room), "post" do
    end
  end
end
