class CreateIntakeMetrics < ActiveRecord::Migration
  def change
    create_view :intake_metrics, materialized: true
  end
end
