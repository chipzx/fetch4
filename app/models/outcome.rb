class Outcome < ActiveRecord::Base
  include MultiTenant

  validates :animal_type_id, :animal_id, :outcome_type_id, :outcome_date, :gender_id, presence: true
  validates :animal_id, uniqueness: { scope: [ :group_id, :outcome_type_id, :outcome_date ] }

  belongs_to :address
  belongs_to :animal_type
  belongs_to :outcome_type
  belongs_to :gender
  belongs_to :group

  def self.within_radius(center_point, radius)
    addrs = Address.within_radius(center_point, radius)
    addr_ids = Array.new
    addrs.to_a.each do |a|
     addr_ids << a.id
    end
    self.where("address_id IN (?)", addr_ids)
  end

  def self.to_outcome(animal, outcome_date)
    outcome = Outcome.new
    outcome.animal_id = animal.anumber
    outcome.group_id = animal.group_id
    outcome.kennel_id = animal.kennel_id
    outcome.animal_type_id = animal.animal_type_id
    outcome.outcome_date = outcome_date
    outcome.outcome_type_id = default_outcome_type_id
    outcome.gender_id = animal.gender_id
    outcome.breed = animal.breed
    outcome.weight = animal.weight
    outcome.coloring = animal.coloring
    outcome.dob = animal.dob
    outcome.dob_known = animal.dob_known
    outcome.description = animal.description
    outcome.microchip_number = animal.microchip_number
    outcome.age = calc_age(outcome_date, animal.dob)
    outcome.fiscal_year = calc_fiscal_year(animal.group_id, outcome_date)
    return outcome
  end

  def self.default_outcome_type_id
    ot = OutcomeType.find_by_name("Unknown")
    return ot.id
  end

  # TODO: Move this to a concern
  # returns string suitable to be inserted as an Interval in the database
  def self.calc_age(end_date, start_date)
    days = end_date.day - start_date.day
    months = end_date.month - start_date.month
    years = end_date.year - start_date.year
    months -= 1 if (days < -15)
    if (months < 0)
      years -= 1
      months += 12
    end
    return (months == 0) ? "#{years} years" : "#{years} years #{months} mon"
  end

  def self.calc_fiscal_year(group_id, outcome_date)
    group = Group.find(group_id)
    fy_quarter = group.fiscal_year_start_quarter
    # 4th quarter will offset year by -3 months, 3rd quarter -6 months, 2nd quarter -9 months
    months_ago = fy_quarter == 1 ? 0 : 5 - fy_quarter * 3 
    return outcome_date.months_ago(months_ago).year
  end

end
