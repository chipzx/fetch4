class LengthOfStayByAgeGroup < ActiveRecord::Base
  include MultiTenant
  
  def self.by_age_groups
    series = Array.new
    d = LengthOfStayByAgeGroup.where("outcome_type = 'Adoption' AND animal_type = 'Dog'").order("sort_order")
    dogs = Array.new
    d.to_a.each do |a|
      dogs << [ a.age_group, a.avg_length_of_stay ]
    end
    c = LengthOfStayByAgeGroup.where("outcome_type = 'Adoption' AND animal_type = 'Cat'").order("sort_order")
    cats = Array.new
    c.to_a.each do |a|
      cats << [ a.age_group, a.avg_length_of_stay ]
    end
    series = [ { name: "Dogs", data: dogs },
               { name: "Cats", data: cats }
             ]
    return series
  end
end
