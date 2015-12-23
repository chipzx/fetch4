require 'rails_helper'

describe AnimalType do

  let (:group) {
    create(:group)
  }
  it "checks multi-tenant methods" do
    AnimalType.current = group.id
    g = AnimalType.current
    expect(g).to eq(group.id)
  end

  it "requires a name and group" do
    AnimalType.current = group.id
    rabbit = create(:animaltype)
    rabbit.save!
    expect(group.id).to eq(rabbit.group_id)
  end

end
