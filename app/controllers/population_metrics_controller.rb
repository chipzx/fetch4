class PopulationMetricsController < ApplicationController

  def index
    @population_by_days = PopulationByDay.population_by_days
  end

end
