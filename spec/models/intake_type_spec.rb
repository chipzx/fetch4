require 'rails_helper'

describe IntakeType do
  let (:group) {
    create(:group)
  }
  it "checks multi-tenant methods" do
    IntakeType.current = group.id
    it = create(:intaketype)
    g = IntakeType.current
    expect(g).to eq(group.id)
  end

  it "requires a name and group" do
    IntakeType.current = group.id
    it = create(:intaketype)
    it.save!
    expect(group.id).to eq(it.group_id)
    expect(it.name).to eq('Stray')
    expect(it.description).to eq('Stray Animal')
  end

  it "prevents duplicate records" do
    IntakeType.current = group.id
    it = create(:intaketype)
    it.save!
    expect {
      it2 = create(:intaketype)
    }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
