FactoryGirl.define do
  factory :user do
    # defaults
    email "test@example.com"
    encrypted_password "xyzabc123uandme"
    group_id 0
    sign_in_count 0
    created_at DateTime.now
    updated_at DateTime.now
  end
end
