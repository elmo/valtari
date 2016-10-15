require 'rails_helper'

RSpec.describe "revenues/index", type: :view do
  before(:each) do
    assign(:revenues, [
      Revenue.create!(),
      Revenue.create!()
    ])
  end

  it "renders a list of revenues" do
    render
  end
end
