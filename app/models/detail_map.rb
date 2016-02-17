class DetailMap < ActiveRecord::Base
  include MultiTenant

  validates :map_name, :center_point_latitude, :center_point_longitude, :radius, :max_intensity, :zoom_level, presence: true
  validates :map_name, uniqueness: { scope: [ :group_id ] }

  def map_id
    return self.map_name.gsub(' ', '_').downcase
  end

  def center_point
    return [ self.center_point_latitude, self.center_point_longitude ]
  end
end
