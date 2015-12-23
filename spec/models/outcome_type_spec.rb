require 'rails_helper'

describe OutcomeType do
  let (:group) {
    create(:group)
  }
  it "checks multi-tenant methods" do
    OutcomeType.current = group.id
    it = create(:outcometype)
    g = OutcomeType.current
    g == group.id
  end

  it "requires a name and group" do
    OutcomeType.current = group.id
    it = create(:outcometype)
    it.save!
    group.id.eql?(it.group)
  end

  it "prevents duplicate records" do
    OutcomeType.current = group.id
    it = create(:outcometype)
    it.save!
    expect {
      it2 = create(:outcometype)
    }.to raise_error(ActiveRecord::RecordInvalid)
  end


end
