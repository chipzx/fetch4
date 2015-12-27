require 'rails_helper'

describe Kennel do

  let(:group) {
    create(:group)
  }
  let(:kenneltype) {
    create(:kenneltype)
  }

  it "checks multi-tenant methods" do
    Kennel.current = group.id
    k = build(:kennel)
    k.kennel_type_id = kenneltype.id
    k.save
    g = Kennel.current 
    expect(g).to eq(group.id)
    expect(k.group_id).to eq(g)
  end

  it "checks required fields" do
    Kennel.current = group.id
    k = build(:kennel)
    k.kennel_type_id = kenneltype.id
    k.name = nil
    expect { k.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "checks for duplicate keys" do
    Kennel.current = group.id
    k = build(:kennel)
    k.kennel_type_id = kenneltype.id
    k.save!
    expect {
      k2 = create(:kennel)
    }.to raise_error(ActiveRecord::RecordInvalid)
    k3 = build(:kennel)
    k3.kennel_type_id = kenneltype.id
    k3.name = 'New name'
    k3.save
    k3.name = k.name
    k3.full_name = true
    k3.building = 'Bldg A'
    k3.save
    k.full_name = true
    k.building = 'Bldg A'
    expect { k.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  # check group_id foreign key 
  it "checks group id foreign key" do
    Kennel.current = group.id
    kennel = build(:kennel)
    kennel.kennel_type_id = kenneltype.id
    kennel.group_id = -1 
    expect { kennel.save! }.to raise_error(ActiveRecord::InvalidForeignKey)
  end

  # check kennel_type_id foreign key 
  it "checks kennel type id foreign key" do
    Kennel.current = group.id
    kennel = build(:kennel)   
    kennel.kennel_type_id = -1
    expect { kennel.save! }.to raise_error(ActiveRecord::InvalidForeignKey)
  end

  it "checks full_name flag" do
    Kennel.current = group.id
    kennel = build(:kennel)
    kennel.kennel_type_id = kenneltype.id
    expect(kennel.kennel_name).to eq("101")
    kennel.full_name = true
    kennel.building = "Bldg A"
    expect(kennel.kennel_name).to eq("Bldg A-101") 
  end
end
