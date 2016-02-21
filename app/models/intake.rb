class Intake < ActiveRecord::Base
  include MultiTenant

  geocoded_by :found_location do |obj, results|
    if geo = results.first
      unless geo.latitude.nil? || geo.latitude == 0.0
        obj.latitude = geo.latitude
        obj.longitude = geo.longitude
        obj.valid_address = true 
        obj.postal_code = geo.postal_code if obj.postal_code.nil?
        obj.found_location = geo.address
        obj.geo_quality_code = geo.geometry['location_type']
      end
    end
  end

  after_validation :geocode, if: ->(obj){ !obj.valid_address }
  
  validates :animal_id, :animal_type_id, :group_id, :gender_id, presence: true
  validates :animal_id, uniqueness: { scope: [ :intake_date, :group_id ] }

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
