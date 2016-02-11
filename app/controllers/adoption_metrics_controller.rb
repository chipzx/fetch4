require 'lazy_high_charts/high_chart_globals'

class AdoptionMetricsController < ApplicationController

  def index
    @by_day_totals = AdoptionsByDay.by_day_totals
    @width="100%"
  end

  def by_day_ajax
    @by_day_totals = AdoptionsByDay.by_day_totals
    render json: @by_day_totals
  end
end
