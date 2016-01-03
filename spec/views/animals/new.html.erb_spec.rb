require 'rails_helper'

RSpec.describe "animals/new", type: :view do
  before(:each) do
    assign(:animal, Animal.new())
  end

  it "renders new animal form" do
    render

    assert_select "form[action=?][method=?]", animals_path, "post" do
    end
  end
end
