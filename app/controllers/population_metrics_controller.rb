class PopulationMetricsController < ApplicationController

  def index
    @io_by_day = PopulationMetric.io_by_day
    @io_by_week = PopulationMetric.io_by_week
    @io_by_month = PopulationMetric.io_by_month
    @io_by_quarter = PopulationMetric.io_by_quarter
  end

end
