class IntakeMetricsController < ApplicationController

  def index
    @by_zip_code = StraysByZipCode.stray_totals
    @width="100%"
  end

  def by_zip_code_ajax
    @by_zip_code_totals = StraysByZipCode.stray_totals
    render json: @by_zip_code
  end
end
