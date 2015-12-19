require 'rails_helper'

describe User do
  it "should return a group name" do
    group1 = create(:group)
    test1 = build(:user)
    test1.group_id = group1.id
    expect(test1.email.eql?('test@example.com'))
    expect(test1.encrypted_password.eql?('xyzabc123uandme'))
    expect(test1.sign_in_count == 0) 
    puts "Group ID is #{test1.group_id}"
    expect(test1.group_name.eql?('root'))
  end

  it "should get group_id by name" do
    group1 = create(:group)
    expect(User.get_group_id(group1.name).eql?(group1.id))
  end
end
