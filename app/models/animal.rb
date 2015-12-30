class Animal < ActiveRecord::Base
  include MultiTenant

  validates :anumber, :animal_type_id, :intake_type_id, presence: true
  validates :anumber, uniqueness: { scope: :group_id }
  
end
