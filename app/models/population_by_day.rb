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
end
