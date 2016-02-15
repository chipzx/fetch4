class DetailMap < ActiveRecord::Base
  include MultiTenant

  validates :map_name, :center_point_latitude, :center_point_longitude, :radius, :max_intensity, :zoom_level, presence: true
  validates :map_name, uniqueness: { scope: [ :group_id ] }

end
