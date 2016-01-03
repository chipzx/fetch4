require 'rails_helper'

RSpec.describe "animals/index", type: :view do
  before(:each) do
    assign(:animals, [
      Animal.create!(),
      Animal.create!()
    ])
  end

  it "renders a list of animals" do
    render
  end
end
