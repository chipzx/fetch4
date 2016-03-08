class UpdateServiceRequestMetricsToVersion2 < ActiveRecord::Migration
  def change
    update_view :service_request_metrics, 
                  version: 2, 
                  revert_to_version: 1,
                  materialized: true
  end
end
