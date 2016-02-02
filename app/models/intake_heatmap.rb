class IntakeHeatmap < ActiveRecord::Base
  include MultiTenant

  scope :with_animal_type, -> type { where("animal_type = ?", type) if type }
  scope :with_intake_type, -> itype { where("intake_type = ?", itype) if itype }
  scope :with_gender_type, -> gtype { where("gender = ?", gtype) if gtype }
  scope :with_fy_type, -> ftype { where("fiscal_year = ?", ftype) if ftype }

  filterrific(
    available_filters: [
      :with_animal_type,
      :with_intake_type,
      :with_gender_type,
      :with_fy_type
    ]
  )

  def self.options_for_animal_type
    all = [ "All", nil ]
    opts = (AnimalType.all.to_a.map { |t| [t.name, t.name] })
    opts.unshift(all)
  end

  def self.options_for_intake_type
    all = [ "All", nil ] 
    opts = (IntakeType.order(:name).to_a.map { |t| [t.name, t.name] })
    opts.unshift(all)
  end

  def self.options_for_gender_type
    all = [ "All", nil ]
    opts = (Gender.order(:description).to_a.map { |t| [t.description, t.description] })
    opts.unshift(all)
  end

  def self.options_for_fy_type
    opts = { "All" => nil, "2014" => "2014", "2015" => "2015" }
  end
end
