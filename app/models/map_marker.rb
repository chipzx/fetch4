class MapMarker < ActiveRecord::Base
  include MultiTenant

  validates :name, :address_id, :icon_type, presence: true
  validates :name, uniqueness: { scope: :group_id }

end
