class AdoptionMetricsController < ApplicationController

  def index
    @by_day_totals = OutcomeMetric.adoptions_by_day_of_week
    @by_hour_totals = OutcomeMetric.adoptions_by_hour
    @by_length_of_stay = OutcomeMetric.adoptions_by_length_of_stay
    @by_age_groups = OutcomeMetric.adoptions_by_age_groups
  end

end
