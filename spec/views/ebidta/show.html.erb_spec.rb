require 'rails_helper'

RSpec.describe "ebidta/show", type: :view do
  before(:each) do
    @ebidtum = assign(:ebidtum, Ebidtum.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
