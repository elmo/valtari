require 'rails_helper'

RSpec.describe "events/index", type: :view do
  before(:each) do
    assign(:events, [
      Event.create!(
        :user_id => 2,
        :title => "Title"
      ),
      Event.create!(
        :user_id => 2,
        :title => "Title"
      )
    ])
  end

  it "renders a list of events" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
  end
end
