class UpdateDayCountDuringYearsToVersion2 < ActiveRecord::Migration
  def change
    conn = ActiveRecord::Base.connection
    conn.execute("DROP VIEW IF EXISTS adoptions_by_days")
    update_view :day_count_during_years, version: 2, revert_to_version: 1
  end
end
