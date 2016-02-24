class LengthOfStayByAgeGroup < ActiveRecord::Base
  include MultiTenant
  
  def self.by_age_groups
    ag = LengthOfStayByAgeGroup.where("outcome_type = 'Adoption' AND animal_type = 'Dog'").order("sort_order")
    data = Array.new
    ag.to_a.each do |a|
      data << [ a.age_group, a.avg_length_of_stay ]
    end
    return data
  end
end
