class AdoptionMetricsController < ApplicationController

  def index
    @by_day_totals = OutcomeMetric.adoptions_by_day_of_week
    @by_hour_totals = OutcomeMetric.adoptions_by_hour
    @by_length_of_stay = LengthOfStayMetric.by_length_of_stay
    @by_age_groups = LengthOfStayMetric.by_age_groups
  end

  def by_day_ajax
    @by_day_totals = AdoptionsByDay.by_day_totals
    render json: @by_day_totals
  end
end
