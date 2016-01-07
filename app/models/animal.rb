class Animal < ActiveRecord::Base
  include MultiTenant

  validates :anumber, :animal_type_id, :intake_type_id, presence: true
  validates :anumber, uniqueness: { scope: :group_id }
  
  searchable do
    text    :name, :anumber, :breed, :coloring, :description, :microchip_number, :animal_type,
:intake_type, :gender, :kennel

    string  :name
    string  :kennel
    string  :breed
    string  :coloring
    string  :anumber
    string  :microchip_number
    integer :age
    integer :days_under_care
    integer :group_id
    integer :weight
    integer :animal_type_id
    integer :intake_type_id
    integer :gender_id
    integer :kennel_id
    date    :dob 
    date    :intake_date

  end

  def animal_type
    AnimalType.find(self.animal_type_id).name
  end

  def intake_type
    IntakeType.find(self.intake_type_id).name
  end

  def gender
    unless self.gender_id.nil?
      g = Gender.find(self.gender_id) 
      g.description unless g.nil?
    end
  end

  def kennel
    unless self.kennel_id.nil?
      k = Kennel.find(self.kennel_id)
      unless k.nil?
        k.kennel_name
      end
    end
  end

  def age
    now = Time.zone.now
    now.year - self.dob.year - ((now.month > self.dob.month || (now.month == self.dob.month && now.day >= dob.day)) ? 0 : 1)
  end 

  def days_under_care
    ((Time.zone.now - self.intake_date)/(24*60*60)).floor
  end

end
