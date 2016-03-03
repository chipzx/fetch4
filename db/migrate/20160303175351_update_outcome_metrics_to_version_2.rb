class UpdateOutcomeMetricsToVersion2 < ActiveRecord::Migration
  def change
    update_view :outcome_metrics,
      version: 2,
      revert_to_version: 1,
      materialized: true
  end
end
