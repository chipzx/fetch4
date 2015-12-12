require 'rails_helper'

describe User do
  it "should return a group name" do
    test1 = build(:user)
    expect(test1.email.eql?('test@example.com'))
    expect(test1.encrypted_password.eql?('xyzabc123uandme'))
    expect(test1.sign_in_count == 0) 
    expect(test1.group_id == 0)
    puts "Group ID is #{test1.group_id}"
    expect(test1.group_name.eql?('root'))
  end
end
