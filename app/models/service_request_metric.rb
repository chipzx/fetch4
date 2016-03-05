class ServiceRequestMetric < ActiveRecord::Base
  include MultiTenant
  include DataSeries

  self.primary_key = :id

  def self.refresh
    Scenic.database.refresh_materialized_view(table_name, concurrently: false)
  end

  def self.service_requests_by_week
    by_week = ServiceRequestMetric.group(:service_request_type, :fiscal_year, :week).order(:service_request_type, :fiscal_year, :week).count
    return create_series(by_week)
  end 

  def self.service_requests_by_month
    by_month = ServiceRequestMetric.group(:service_request_type, :fiscal_year, :month).order(:service_request_type, :fiscal_year, :month).count
    return create_series(by_month)
  end

  def self.service_requests_by_quarter
    by_quarter = ServiceRequestMetric.group(:service_request_type, :fiscal_year, :quarter).order(:service_request_type, :fiscal_year, :quarter).count
    return create_series(by_quarter)
  end

  def self.service_requests_by_zip_code
    by_zip_code = ServiceRequestMetric.group(:service_request_type, :fiscal_year, :postal_code).order(:service_request_type, :fiscal_year, :postal_code).count
    return create_by_year_series(by_zip_code)
  end

  private
  def readonly?
    true
  end

end
