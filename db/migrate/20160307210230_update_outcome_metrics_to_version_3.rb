class UpdateOutcomeMetricsToVersion3 < ActiveRecord::Migration
  def change
    update_view :outcome_metrics,
      version: 3,
      revert_to_version: 2,
      materialized: true
  end
end
