require 'rails_helper'

RSpec.describe "animals/show", type: :view do
  before(:each) do
    @animal = assign(:animal, Animal.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
