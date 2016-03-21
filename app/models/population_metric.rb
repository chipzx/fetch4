class PopulationMetric < ActiveRecord::Base
  include MultiTenant
  include DataSeries

  def self.io_by_day
    intakes = hash_entries(IntakeMetric.intakes_by_day)
    outcomes = hash_entries(OutcomeMetric.outcomes_by_day)
    return merge_totals_by_key(intakes, outcomes)
  end

  def self.io_by_month
    intakes = hash_entries(IntakeMetric.intakes_by_month)
    outcomes = hash_entries(OutcomeMetric.outcomes_by_month)
    return merge_totals_by_key(intakes, outcomes)
  end

  def self.io_by_week
    intakes = hash_entries(IntakeMetric.intakes_by_week)
    outcomes = hash_entries(OutcomeMetric.outcomes_by_week)
    return merge_totals_by_key(intakes, outcomes)
  end

  def self.io_by_quarter
    intakes = hash_entries(IntakeMetric.intakes_by_quarter)
    outcomes = hash_entries(OutcomeMetric.outcomes_by_quarter)
    return merge_totals_by_key(intakes, outcomes)
  end

  # private
  def readonly?
    true
  end

end
