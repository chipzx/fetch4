require 'rails_helper'

describe Animal do
  let(:group) {
    create(:group)
  }
  let(:animaltype) {
    create(:animaltype)
  }
  let(:intaketype) {
    create(:intaketype)
  }
  let(:gender) {
    create(:gender)
  }
  let(:animal) {
    build(:animal)
  }
  let(:test_animal) {
    build(:animal)
  }

  before(:each) do
    Animal.current = group.id
    test_animal.intake_type_id = intaketype.id
    test_animal.animal_type_id = animaltype.id
    test_animal.gender_id = gender.id
    test_animal.group_id = group.id
    test_animal.save!
  end

  # check presence validation
  it "checks required fields" do
    animal.anumber = nil
    expect { animal.save! }.to raise_error(ActiveRecord::RecordInvalid) 
    animal.intake_type_id = intaketype.id
    expect { animal.save! }.to raise_error(ActiveRecord::RecordInvalid) 
    animal.animal_type_id = animaltype.id
    animal.anumber = 'A999999'
    animal.save!
    expect(animal.group_id).to eq(group.id)
  end

  # check uniqueness validation
  it "checks unique fields" do
    animal2 = build(:animal)
    animal2.intake_type_id = intaketype.id
    animal2.animal_type_id = animaltype.id
    expect { animal2.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  # check animal_type_id foreign key
  it "checks animal type id foreign key" do
    test_animal.animal_type_id = -1
    expect { test_animal.save! }.to raise_error(ActiveRecord::InvalidForeignKey)
  end

  # check intake_type_id foreign key
  it "checks intake type id foreign key" do
    test_animal.intake_type_id = -1
    expect { test_animal.save! }.to raise_error(ActiveRecord::InvalidForeignKey)
  end

  # check group_id foreign key
  it "checks group id foreign key" do
    Animal.current = group.id
    animal = build(:animal)   
    animal.intake_type_id = intaketype.id
    animal.animal_type_id = animaltype.id
    animal.group_id = -1
    expect { animal.save! }.to raise_error(ActiveRecord::InvalidForeignKey)
  end

  # check html formatting of notes
  it "checks formatting of notes" do
    test_animal.description = "Testing html formatting.\r\nThis should have a break inserted"
    test_animal.save!
    expect(test_animal.notes).to include("<br/>") 
    expect(test_animal.notes(to_html: false)).not_to include("<br/>")
  end

  it "checks gender function" do
    expect(test_animal.gender).to eq("Neutered Male")
  end
end
