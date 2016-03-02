class PopulationMetricsController < ApplicationController

  def index
    @population_by_days = PopulationByDay.population_by_days
    @io_by_week = PopulationMetric.io_by_week
    @io_by_month = PopulationMetric.io_by_month
  end

end
