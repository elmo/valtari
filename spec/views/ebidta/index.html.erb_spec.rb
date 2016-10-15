require 'rails_helper'

RSpec.describe "ebidta/index", type: :view do
  before(:each) do
    assign(:ebidta, [
      Ebidtum.create!(
        :name => "Name"
      ),
      Ebidtum.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of ebidta" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
