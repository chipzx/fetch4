class CreateDayCountDuringYears < ActiveRecord::Migration
  def change
    create_view :day_count_during_years
  end
end
