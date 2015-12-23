require 'rails_helper'

describe OutcomeType do
  let (:group) {
    create(:group)
  }
  let (:new_group) {
    create(:new_group)
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

  it "provisions to a new group" do
    OutcomeType.current = group.id
    it = create(:outcometype)
    it.save!
    puts("Group Id is #{group.id}, new group id is #{new_group.id}")
    it_all = OutcomeType.all
    OutcomeType.provision(group.id, new_group.id)
    # TODO: Add assertions
    # validation happens inside provision method - have problem with newly
    # created records showing up in test environment [ccy 2015/12/23]
  end

end
