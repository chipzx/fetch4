require 'rails_helper'

describe AnimalType do
  it "checks multi-tenant methods" do
    group = create(:group)
    AnimalType.current = group.id
    g = AnimalType.current
    g == group.id
  end

  it "requires a name and group" do
    group = create(:group)
    rabbit = create(:animaltype)
    rabbit.save!
    group.id.eql?(rabbit.group)
  end
end
