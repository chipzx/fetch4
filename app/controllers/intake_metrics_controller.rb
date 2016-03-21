class IntakeMetricsController < ApplicationController
  def index
    @intakes_by_zip_code = IntakeMetric.intakes_by_zip_code
    @intakes_by_gender = IntakeGender.by_intake_gender
    @intakes_by_day = IntakeMetric.intakes_by_day
    @intakes_by_week = IntakeMetric.intakes_by_week
    @intakes_by_month = IntakeMetric.intakes_by_month
    @intakes_by_quarter = IntakeMetric.intakes_by_quarter
    @width="100%"
  end
end
