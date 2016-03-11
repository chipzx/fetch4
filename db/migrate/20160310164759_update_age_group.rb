class UpdateAgeGroup < ActiveRecord::Migration
  def up
    conn = ActiveRecord::Base.connection
    add_column :age_groups, :from_in_months, :integer, null: false, default: 0
    add_column :age_groups, :to_in_months, :integer, null: false, default: 0

    conn.execute("UPDATE age_groups SET from_in_months = 0, to_in_months = 5 WHERE name = '0-5 Months'")
    conn.execute("UPDATE age_groups SET from_in_months = 5, to_in_months = 12 WHERE name = '5 Mos-1 yr'")
    conn.execute("UPDATE age_groups SET from_in_months = 12, to_in_months = 24 WHERE name = '1-2 years'")
    conn.execute("UPDATE age_groups SET from_in_months = 24, to_in_months = 84 WHERE name = '2-7 years'")
    conn.execute("UPDATE age_groups SET from_in_months = 84, to_in_months = 120 WHERE name = '7-10 years'")
    conn.execute("UPDATE age_groups SET from_in_months = 120, to_in_months = 999 WHERE name = '10+ years'")
  end

  def down
    remove_column :age_groups, :from_in_months
    remove_column :age_groups, :to_in_months
  end
end
