class ServiceRequestMetric < ActiveRecord::Base
  include MultiTenant
  include DataSeries

  self.primary_key = :id

  def self.refresh
    Scenic.database.refresh_materialized_view(table_name, concurrently: false)
  end

  def self.service_requests_by_week
    return service_requests_by_period(:week);
  end 

  def self.service_requests_by_month
    return service_requests_by_period(:month);
  end

  def self.service_requests_by_quarter
    return service_requests_by_period(:quarter);
  end

  def self.service_requests_by_zip_code
    by_zip_code = ServiceRequestMetric.where("postal_code IN (SELECT postal_code FROM (SELECT postal_code, count(*) as totals FROM service_request_metrics where postal_code IS NOT NULL group by postal_code order by totals DESC LIMIT 10) top_zips) AND rank <= 7").group(:service_request_type, :postal_code).order("count_all DESC").count
    return create_hc_series(by_zip_code)
  end

  private
  def readonly?
    true
  end

  def self.service_requests_by_period(period)
    by_period = ServiceRequestMetric.where("rank <= 7").group(:service_request_type, :fiscal_year, period).order(:service_request_type, :fiscal_year, period).count
    return create_hc_series(by_period)

  end
end
