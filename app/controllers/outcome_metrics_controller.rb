class OutcomeMetricsController < ApplicationController

  def index
    @outcomes_by_day = OutcomeMetric.outcomes_by_day
    @outcomes_by_week = OutcomeMetric.outcomes_by_week
    @outcomes_by_month = OutcomeMetric.outcomes_by_month
    @outcomes_by_zip_code = OutcomeMetric.outcomes_by_zip_code
    @outcomes_by_gender = OutcomeMetric.outcomes_by_gender
  end

end
