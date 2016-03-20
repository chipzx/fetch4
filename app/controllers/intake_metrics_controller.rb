class IntakeMetricsController < ApplicationController

  def index
#    @by_zip_code = StraysByZipCode.stray_totals
    @by_zip_code = IntakeMetric.intakes_by_zip_code
    @by_intake_gender = IntakeGender.by_intake_gender
    @intake_by_days = PopulationByDay.intake_by_days
    @intakes_by_week = IntakeMetric.intakes_by_week
    @intakes_by_month = IntakeMetric.intakes_by_month
    @width="100%"
  end

  def by_zip_code_ajax
    @by_zip_code_totals = StraysByZipCode.stray_totals
    render json: @by_zip_code
  end
end
