require 'rails_helper'

RSpec.describe "private/deal_rooms/index", type: :view do
  before(:each) do
    assign(:private_deal_rooms, [
      Private::DealRoom.create!(),
      Private::DealRoom.create!()
    ])
  end

  it "renders a list of private/deal_rooms" do
    render
  end
end
