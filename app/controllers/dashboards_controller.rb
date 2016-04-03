class DashboardsController < ApplicationController
  include Chartkick::Remote
  chartkick_remote

  def index
    @intakes_by_period = IntakeMetric.intakes_by_month
    @outcomes_by_period = OutcomeMetric.outcomes_by_month
    
  end
end
