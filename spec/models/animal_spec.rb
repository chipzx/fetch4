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

  # check presence validation
  it "checks required fields" do
    Animal.current = group.id
    animal = build(:animal)   
    expect { animal.save! }.to raise_error(ActiveRecord::RecordInvalid) 
    animal.intake_type_id = intaketype.id
    expect { animal.save! }.to raise_error(ActiveRecord::RecordInvalid) 
    animal.animal_type_id = animaltype.id
    animal.save!
    expect(animal.group_id).to eq(group.id)
    animal.anumber = nil
    expect { animal.save! }.to raise_error(ActiveRecord::RecordInvalid) 
  end

  # check uniqueness validation
  it "checks unique fields" do
    Animal.current = group.id
    animal = build(:animal)   
    animal.intake_type_id = intaketype.id
    animal.animal_type_id = animaltype.id
    animal.save!
    a2 = build(:animal)
    a2.intake_type_id = intaketype.id
    a2.animal_type_id = animaltype.id
    expect { a2.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  # check animal_type_id foreign key
  it "checks animal type id foreign key" do
    Animal.current = group.id
    animal = build(:animal)   
    animal.intake_type_id = intaketype.id
    animal.animal_type_id = animaltype.id
    animal.save!
    animal.animal_type_id = -1
    expect { animal.save! }.to raise_error(ActiveRecord::InvalidForeignKey)
  end

  # check intake_type_id foreign key
  it "checks intake type id foreign key" do
    Animal.current = group.id
    animal = build(:animal)   
    animal.intake_type_id = intaketype.id
    animal.animal_type_id = animaltype.id
    animal.save!
    animal.intake_type_id = -1
    expect { animal.save! }.to raise_error(ActiveRecord::InvalidForeignKey)
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


end
