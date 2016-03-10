class ServiceRequestMetricsController < ApplicationController

  def index
    @service_requests_by_week = ServiceRequestMetric.service_requests_by_week
    @service_requests_by_month = ServiceRequestMetric.service_requests_by_month
    @service_requests_by_quarter = ServiceRequestMetric.service_requests_by_quarter
    @service_requests_by_zip_code = ServiceRequestMetric.service_requests_by_zip_code
  end

end
