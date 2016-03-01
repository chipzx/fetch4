class CreateOutcomeMetrics < ActiveRecord::Migration
  def change
    create_view :outcome_metrics, materialized: true
  end
end
