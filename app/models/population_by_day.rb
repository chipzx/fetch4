class PopulationByDay < ActiveRecord::Base
  include MultiTenant

  validates :calendar_date, :total_intakes, :total_outcomes, presence: true
  validates :calendar_date, uniqueness: { scope: :group_id }

  def self.population_by_days
    by_days = PopulationByDay.all
    data = Array.new
    by_days.to_a.each do |d|
      data << [ d.calendar_date, d.total_outcomes - d.total_intakes ]
    end
    return data
  end

  def self.outcome_by_days
    outcomes = PopulationByDay.all
    series = Array.new
    outcomes.to_a.each do |o|
      series << [ o.calendar_date, o.total_outcomes ]
    end
    return series
  end

  def self.intake_by_days
    intakes = PopulationByDay.all
    series = Array.new
    intakes.to_a.each do |i|
      series << [ i.calendar_date, i.total_intakes]
    end
    return series
  end

end
