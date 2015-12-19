FactoryGirl.define do
  factory :group do
    name 'root'
    description 'admin group'
    id 1
    time_zone 'UTC'
    created_at DateTime.now
    updated_at DateTime.now
  end
  factory :user do
    # defaults
    email "test@example.com"
    encrypted_password "xyzabc123uandme"
    group_id 1
    sign_in_count 0
    created_at DateTime.now
    updated_at DateTime.now
  end
  factory :animaltype, class: AnimalType do
    name 'Rabbit'
    group_id 1
    description 'Rabbits and Bunnies'
    created_at DateTime.now
    updated_at DateTime.now
  end
end
