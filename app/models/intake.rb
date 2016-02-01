class Intake < ActiveRecord::Base
  include MultiTenant

  validates :animal_id, :animal_type_id, :group_id, :gender_id, presence: true
  validates :animal_id, uniqueness: { scope: [ :intake_date, :group_id ] }

filterrific(
  default_filter_params: { sorted_by: 'created_at_desc' },
  available_filters: [
    :sorted_by,
    :search_query,
    :with_country_id,
    :with_created_at_gte
  ]
)
  def animal_type
    at = AnimalType.find(self.animal_type_id)
    at.nil? ? nil : at.name
  end

  def gender
    g = Gender.find(self.gender_id)
    g.nil? ? nil : g.name
  end

  def intake_type
    it = IntakeType.find(self.intake_type_id)
    it.nil? ? nil : it.name
  end

end
