class CreateServiceRequestMetrics < ActiveRecord::Migration
  def change
    create_view :service_request_metrics, materialized: true
  end
end
