require 'rails_helper'

RSpec.describe "revenues/show", type: :view do
  before(:each) do
    @revenue = assign(:revenue, Revenue.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
