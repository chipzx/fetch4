class IntakeGender < ActiveRecord::Base
  include MultiTenant

  def self.by_intake_gender
    series = Array.new
    intakes = IntakeGender.where("intake_type = 'Stray' and animal_type  = 'Dog' and gender NOT LIKE '%Unknown%'").order("animal_type, gender")
    dogs = Array.new
    intakes.to_a.each do |i|
      dogs << [i.gender, i.total]
    end
    intakes = IntakeGender.where("intake_type = 'Stray' and animal_type  = 'Cat' AND gender NOT LIKE '%Unknown%'").order("animal_type, gender")
    cats = Array.new
    intakes.to_a.each do |i|
      cats << [i.gender, i.total]
    end
    series = [ { name: "Dogs", data: dogs },
               { name: "Cats", data: cats }
             ]
    return series
  end

end
