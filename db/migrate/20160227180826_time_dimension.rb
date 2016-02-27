class TimeDimension < ActiveRecord::Migration
  def up
    create_table :time_dimension do |t|
      t.date :calendar_date, null: false
      t.integer :calendar_year, null: false
      t.integer :month, null: false
      t.integer :day_of_month, null: false
      t.integer :day_of_week, null: false
      t.integer :day_of_year, null: false
      t.integer :week, null: false
      t.integer :quarter, null: false
    end

    add_index :time_dimension, :calendar_date, unique: true
  end
  def down
    drop_table :time_dimension
  end
end
