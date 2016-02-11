class Outcome < ActiveRecord::Base
  include MultiTenant

  validates :animal_type_id, :animal_id, :outcome_type_id, :outcome_date, :gender_id, presence: true
  validates :animal_id, uniqueness: { scope: [ :group_id, :outcome_type_id, :outcome_date ] }
end
