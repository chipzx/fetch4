require 'rails_helper'

describe RoleRight do

  let(:group) {
    create(:group)
  }

  let (:new_group) {
    create(:new_group)
  }

  let(:role) {
    build(:role)
  }

  let(:right) {
    create(:right)
  }

  before(:each) do
    RoleRight.current = group.id
    role.save!
    right.save!
  end

  it "checks required fields" do
    rr = RoleRight.new
    expect(rr.role_id).to be_nil
    expect(rr.right_id).to be_nil
    expect{rr.save!}.to raise_error(ActiveRecord::RecordInvalid)
    rr.role_id = role.id
    expect{rr.save!}.to raise_error(ActiveRecord::RecordInvalid)
    rr.right_id = right.id
    rr.group_id = group.id
    rr.created_at = DateTime.now
    rr.updated_at = DateTime.now    
    rr.save!
    expect(RoleRight.all.size).to eq(1)
  end

  it "checks unique fields" do
  end

  it "provisions to a new group" do
    rr = RoleRight.new
    rr.role_id = role.id
    rr.right_id = right.id
    rr.group_id = group.id
    rr.save!
    RoleRight.provision(role.group_id, new_group.id)
  end

end
