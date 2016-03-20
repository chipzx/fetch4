class ServiceRequestMetric < ActiveRecord::Base
  include MultiTenant
  include DataSeries

  self.primary_key = :id

  def self.refresh
    Scenic.database.refresh_materialized_view(table_name, concurrently: false)
  end

  def self.service_requests_by_week
    by_week = ServiceRequestMetric.where("rank <= 5").group(:service_request_type, :fiscal_year, :week).order(:service_request_type, :fiscal_year, :week).count
    return create_hc_series(by_week)
  end 

  def self.service_requests_by_month
    by_month = ServiceRequestMetric.where("rank <= 5").group(:service_request_type, :fiscal_year, :month).order(:service_request_type, :fiscal_year, :month).count
    return create_hc_series(by_month)
  end

  def self.service_requests_by_quarter
    by_quarter = ServiceRequestMetric.where("rank <= 5").group(:service_request_type, :fiscal_year, :quarter).order(:service_request_type, :fiscal_year, :quarter).count
    return create_hc_series(by_quarter)
  end

  def self.service_requests_by_zip_code
    by_zip_code = ServiceRequestMetric.where("postal_code IN (SELECT postal_code FROM (SELECT postal_code, count(*) as totals FROM service_request_metrics where postal_code IS NOT NULL group by postal_code order by totals DESC LIMIT 10) top_zips) AND rank <= 7").group(:service_request_type, :postal_code).order("count_all DESC").count
    return create_hc_series(by_zip_code)
  end

  private
  def readonly?
    true
  end

end
