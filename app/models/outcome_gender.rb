class OutcomeGender < ActiveRecord::Base
  include MultiTenant

  def self.by_outcome_gender
    series = Array.new
    outcomes = OutcomeGender.where("animal_type  = 'Dog' and gender NOT LIKE '%Unknown%'").order("animal_type, gender")
    dogs = Array.new
    outcomes.to_a.each do |i|
      dogs << [i.gender, i.total]
    end
    outcomes = OutcomeGender.where("animal_type  = 'Cat' AND gender NOT LIKE '%Unknown%'").order("animal_type, gender")
    cats = Array.new
    outcomes.to_a.each do |i|
      cats << [i.gender, i.total]
    end
    series = [ { name: "Dogs", data: dogs },
               { name: "Cats", data: cats }
             ]
    return series
  end

end
