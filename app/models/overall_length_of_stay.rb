class OverallLengthOfStay < ActiveRecord::Base
  include MultiTenant

  def self.by_length_of_stay
    los = OverallLengthOfStay.select("animal_type, group_id, avg_length_of_stay").where("outcome_type = 'Adoption'").order("animal_type")
    data = Array.new
    los.to_a.each do |l|
      data << [ l.animal_type, l.avg_length_of_stay ]
    end
    return data
  end
end
