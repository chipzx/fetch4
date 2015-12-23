FactoryGirl.define do
  factory :group do
    name 'root'
    description 'admin group'
    id 1
    time_zone 'UTC'
    created_at DateTime.now
    updated_at DateTime.now
  end
  factory :new_group, class: Group do
    name 'test'
    description 'test group'
    id 2
    time_zone 'US/Central'
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
    description 'Rabbits and Bunnies'
    created_at DateTime.now
    updated_at DateTime.now
  end
  factory :intaketype, class:IntakeType do
    name 'Stray'
    description 'Stray Animal'
    created_at DateTime.now
    updated_at DateTime.now
  end
  factory :outcometype, class:OutcomeType do
    name 'Adoption'
    description 'Animal adopted'
    created_at DateTime.now
    updated_at DateTime.now
  end
  factory :animal do
    anumber 'A123456'
  end
  factory :gender do
    name 'X'
    description 'Unknown'
    created_at DateTime.now
    updated_at DateTime.now
  end
end
