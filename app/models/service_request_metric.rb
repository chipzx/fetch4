class ServiceRequestMetric < ActiveRecord::Base
  include MultiTenant
  include DataSeries

end
