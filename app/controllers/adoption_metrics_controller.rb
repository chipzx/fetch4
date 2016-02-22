class AdoptionMetricsController < ApplicationController

  def index
    @by_day_totals = AdoptionsByDay.by_day_totals
    @by_hour_totals = AdoptionsByHour.by_hour_totals
    @width="100%"
  end

  def by_day_ajax
    @by_day_totals = AdoptionsByDay.by_day_totals
    render json: @by_day_totals
  end
end
