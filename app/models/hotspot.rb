class Hotspot < ActiveRecord::Base
  include MultiTenant
  validates :group_id, :animal_id, :animal_type_id, :intake_type_id, presence: true
end
