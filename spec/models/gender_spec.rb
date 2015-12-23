require 'rails_helper'

describe Gender do
  let (:group) {
    create(:group)
  }

  it "checks multi-tenant methods" do
    Gender.current = group.id
    g = Gender.current
    expect(g).to eq(group.id)
  end

  it "checks required fields" do
    Gender.current = group.id
    g = create(:gender)
    g.name = nil
    g.description = nil
    expect { g.save! }.to raise_error(ActiveRecord::RecordInvalid)
    g.name = 'M'
    expect { g.save! }.to raise_error(ActiveRecord::RecordInvalid)
    g.description = 'Male (Intact)'
    g.save!
    expect(g.group_id).to eq(group.id)
    expect(g.name).to eq("M")
    expect(g.description).to eq("Male (Intact)")
  end

  it "prevents duplicate records" do
    Gender.current = group.id
    g = create(:gender)
    g.name = 'S'
    g.description = 'Spayed Female'
    g.save!
    g2 = create(:gender)
    g2.name = 'S'
    g2.description = 'Something Else'
    expect { g2.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "checks group_id foreign key" do
    Gender.current = group.id
    g = create(:gender)
    g.name = 'S'
    g.description = 'Spayed Female'
    g.save!
    g.group_id = -1
    expect { g.save! }.to raise_error(ActiveRecord::InvalidForeignKey)
  end

end
