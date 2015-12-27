require 'rails_helper'

describe KennelType do
  let (:group) {
    create(:group)
  }
  let (:new_group) {
    create(:new_group)
  }

  it "checks multi-tenant methods" do
    KennelType.current = group.id
    it = create(:kenneltype)
    g = KennelType.current
    g == group.id
  end

  it "requires a name and group" do
    KennelType.current = group.id
    kt = create(:kenneltype)
    kt.save!
    group.id.eql?(kt.group)
  end

  it "prevents duplicate records" do
    KennelType.current = group.id
    kt = create(:kenneltype)
    kt.save!
    expect {
      kt2 = create(:kenneltype)
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "provisions to a new group" do
    KennelType.current = group.id
    kt = create(:kenneltype)
    kt.save!
    puts("Group Id is #{group.id}, new group id is #{new_group.id}")
    kt_all = KennelType.all
    KennelType.provision(group.id, new_group.id)
    # TODO: Add assertions
    # validation happens inside provision method - have problem with newly
    # created records showing up in test environment [ccy 2015/12/23]
  end

end
