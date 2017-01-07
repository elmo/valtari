require 'rails_helper'

RSpec.describe "events/edit", type: :view do
  before(:each) do
    @event = assign(:event, Event.create!(
      :user_id => 1,
      :title => "MyString"
    ))
  end

  it "renders the edit event form" do
    render

    assert_select "form[action=?][method=?]", event_path(@event), "post" do

      assert_select "input#event_user_id[name=?]", "event[user_id]"

      assert_select "input#event_title[name=?]", "event[title]"
    end
  end
end
