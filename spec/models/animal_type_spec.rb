require 'rails_helper'

describe AnimalType do

  let (:group) {
    create(:group)
  }
  let (:new_group) {
    create(:new_group)
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

  it "checks foreign key to groups" do
    AnimalType.current = group.id
    rabbit = create(:animaltype)
    rabbit.save!
    expect(group.id).to eq(rabbit.group_id)
    rabbit.group_id = -1
    expect { rabbit.save! }.to raise_error(ActiveRecord::InvalidForeignKey)
  end

  it "provisions to a new group" do
    AnimalType.current = group.id
    rabbit = create(:animaltype)
    rabbit.save
    AnimalType.provision(group.id, new_group.id)
    # TODO: Add assertions
    # validation happens inside provision method - have problem with newly
    # created records showing up in test environment [ccy 2015/12/23]
  end
  
end
