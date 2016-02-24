class AdoptionMetricsController < ApplicationController

  def index
    @by_day_totals = AdoptionsByDay.by_day_totals
    @by_hour_totals = AdoptionsByHour.by_hour_totals
    @by_length_of_stay = OverallLengthOfStay.by_length_of_stay
    @by_age_groups = LengthOfStayByAgeGroup.by_age_groups
    @width="100%"
  end

  def by_day_ajax
    @by_day_totals = AdoptionsByDay.by_day_totals
    render json: @by_day_totals
  end
end
