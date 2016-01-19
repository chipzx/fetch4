FactoryGirl.define do
  factory :admin, class: User do
    email 'admin@fetchitsoftware.com'
    password "password"
    password_confirmation "password"
    confirmed_at Date.today
  end
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
    name 'N'
    description 'Neutered Male'
    created_at DateTime.now
    updated_at DateTime.now
  end
  factory :kenneltype, class: KennelType do
    name 'Standard'
    created_at DateTime.now
    updated_at DateTime.now
  end
  factory :kennel do
    name '101'
    created_at DateTime.now
    updated_at DateTime.now
  end
  factory :role do
    name 'Admin'
    description 'Administrator Role'
    active true
  end
  factory :right do 
    resource 'animal'
    action 'index'
    created_at DateTime.now
    updated_at DateTime.now
  end
  factory :privilege do
    created_at DateTime.now
    updated_at DateTime.now
  end
  factory :userrole, class: UserRole do
    created_at DateTime.now
    updated_at DateTime.now
  end
end
