class CreateOutcomes < ActiveRecord::Migration

  def up
    conn = ActiveRecord::Base.connection
    create_table :outcomes do |t|
      t.integer :animal_type_id, :null => false
      t.string :animal_id, :null => false
      t.string :name
      t.integer :outcome_type_id, :null => false
      t.timestamp :outcome_date, :null => false
      t.integer :gender_id, :null => false
      t.integer :address_id
      t.string :breed
      t.string :coloring
      t.string :weight
      t.timestamp :dob
      t.boolean :dob_known
      t.timestamp :intake_date
      t.integer :intake_type_id
      t.text :description
      t.integer :group_id, :null => false
      t.decimal :weight
      t.string :microchip_number

      t.timestamps null: false
    end  

    conn.execute("ALTER TABLE outcomes ALTER intake_date TYPE timestamp with time zone")
    conn.execute("ALTER TABLE outcomes ALTER outcome_date TYPE timestamp with time zone")
    conn.execute("ALTER TABLE outcomes ALTER dob TYPE timestamp with time zone")
    conn.execute("ALTER TABLE outcomes ADD COLUMN age interval")

    add_index :outcomes, [:animal_id, :outcome_type_id, :outcome_date, :group_id], { name: 'outcomes_unique_idx', unique: true }
    add_index :outcomes, :name
    add_index :outcomes, :group_id
    add_index :outcomes, :intake_type_id
    add_index :outcomes, :outcome_type_id
    add_index :outcomes, :microchip_number

    conn.execute("ALTER TABLE outcomes ADD CONSTRAINT outcomes_group_fk FOREIGN KEY (group_id) REFERENCES groups(id)")
    conn.execute("ALTER TABLE outcomes ADD CONSTRAINT outcomes_animal_type_fk FOREIGN KEY (animal_type_id) REFERENCES animal_types(id)")
    conn.execute("ALTER TABLE outcomes ADD CONSTRAINT outcomes_intake_type_fk FOREIGN KEY (intake_type_id) REFERENCES intake_types(id)")
    conn.execute("ALTER TABLE outcomes ADD CONSTRAINT outcomes_outcome_type_fk FOREIGN KEY (outcome_type_id) REFERENCES outcome_types(id)")

  end

  def down
    drop_table :outcomes
  end
end
