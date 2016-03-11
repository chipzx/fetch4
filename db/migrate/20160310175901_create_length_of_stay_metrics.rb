class CreateLengthOfStayMetrics < ActiveRecord::Migration
  def change
    conn = ActiveRecord::Base.connection
    conn.execute("DROP VIEW IF EXISTS overall_length_of_stays")
    conn.execute("DROP VIEW IF EXISTS length_of_stay_by_age_groups")
    create_view :length_of_stay_metrics
  end
end
