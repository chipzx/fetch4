class Address < ActiveRecord::Base

  validates :party_id, :address_type_id, :street_address_1, :city, :state, :postal_code, :country, presence: true
  validates :street_address_1, uniqueness: {scope: [ :party_id, :street_address_2, :city, :state, :postal_code, :country, :address_type_id ] }

  geocoded_by :address do |obj, results|
    if geo = results.first
      puts geo.data
        unless geo.latitude.nil? || geo.latitude == 0.0
          obj.latitude = geo.latitude
          obj.longitude = geo.longitude
          obj.valid_address = true 
          obj.full_location = geo.address
          obj.city = geo.city unless geo.city.nil?
          obj.postal_code = geo.postal_code if obj.postal_code.nil?
          obj.geo_quality_code = geo.geometry['location_type']
          obj.feature_type = geo.data['types'].compact.join(",")
          obj.partial_match = geo.data['partial_match']
        end
    end
  end

  after_validation :geocode, if: ->(obj){ !obj.valid_address }
  
  has_many :outcomes
  has_many :intakes
  has_many :animal_services311_calls

  def address
    return "#{street_address_1} #{street_address_2}, #{city}, #{state} #{postal_code} #{country}"
  end

  def self.within_radius(center_point, radius)
    box = Geocoder::Calculations.bounding_box(center_point, radius)
    self.within_bounding_box(box)
  end

end
