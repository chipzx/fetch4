class OutcomeMetricsController < ApplicationController

  def index
    @outcomes_by_day = PopulationByDay.outcome_by_days
    @outcomes_by_week = OutcomeMetric.outcomes_by_week
    @outcomes_by_month = OutcomeMetric.outcomes_by_month
    @outcomes_by_zip_code = OutcomesByZipCode.by_zip_code
    @by_outcome_gender = OutcomeGender.by_outcome_gender
    @width="100%"
  end

end
