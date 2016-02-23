class PopulationByDay < ActiveRecord::Migration
  def up
    conn = ActiveRecord::Base.connection
    create_table :population_by_days do |t|
      t.timestamp :calendar_date, :null => false
      t.integer :group_id, :null => false
      t.integer :total_intakes
      t.integer :total_outcomes
      t.integer :total_population
      t.timestamps null: false
    end

    add_index :population_by_days, [ :calendar_date, :group_id ], unique: true
    add_index :population_by_days, :group_id

    conn.execute("ALTER TABLE population_by_days ADD CONSTRAINT population_by_days_group_id_fk FOREIGN KEY (group_id) REFERENCES groups(id)")
    conn.execute("ALTER TABLE population_by_days ALTER COLUMN calendar_date SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE population_by_days ALTER COLUMN created_at SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE population_by_days ALTER COLUMN updated_at SET DATA TYPE timestamp with time zone")

  end

  def down
    drop_table population_by_days
  end
end
