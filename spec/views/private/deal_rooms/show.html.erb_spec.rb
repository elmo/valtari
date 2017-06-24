require 'rails_helper'

RSpec.describe "private/deal_rooms/show", type: :view do
  before(:each) do
    @private_deal_room = assign(:private_deal_room, Private::DealRoom.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
