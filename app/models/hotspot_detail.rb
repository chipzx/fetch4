class HotspotDetail < ActiveRecord::Base
  include MultiTenant
  validates :found_location, :latitude, :longitude, :total , presence: true
end
