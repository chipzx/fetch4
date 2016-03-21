class UpdateOutcomeMetricsToVersion4 < ActiveRecord::Migration
  def change
    update_view :outcome_metrics,
      version: 4,
      revert_to_version: 3,
      materialized: true
  end
end
