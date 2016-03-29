class UpdateOutcomeMetricsToVersion4 < ActiveRecord::Migration
  def change
    conn = ActiveRecord::Base.connection
    conn.execute("DROP VIEW IF EXISTS length_of_stay_metrics")
    update_view :outcome_metrics,
      version: 4,
      revert_to_version: 3,
      materialized: true
  end
end
