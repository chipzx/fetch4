class CreateIntake < ActiveRecord::Migration
  def up
    conn = ActiveRecord::Base.connection

    create_table :intakes do |t|
      t.integer :animal_type_id, :null => false
      t.string :animal_id, :null => false
      t.string :name
      t.integer :group_id, :null => false
      t.timestamp :intake_date
      t.integer :intake_type_id, :null => false
      t.string :found_location
      t.string :postal_code
      t.integer :address_id
      t.integer :gender_id, :null => false
      t.string  :breed
      t.string  :coloring
      t.string  :age
      t.float   :weight
      t.float :latitude
      t.float :longitude
      t.integer :geo_quality_code
      t.boolean :parseable_address
      t.boolean :valid_address
      t.string :fiscal_year
      t.timestamps null: false
    end
    
    add_index :intakes, [:animal_id, :intake_date, :group_id], :unique => true
    add_index :intakes, :intake_date
    add_index :intakes, :group_id
    add_index :intakes, :intake_type_id
    add_index :intakes, :postal_code
    add_index :intakes, :geo_quality_code

    conn.execute("ALTER TABLE intakes ALTER COLUMN intake_date SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE intakes ADD CONSTRAINT intakes_animal_type_id_fk FOREIGN KEY (animal_type_id) REFERENCES animal_types(id)")
    conn.execute("ALTER TABLE intakes ADD CONSTRAINT intakes_group_id_fk FOREIGN KEY (group_id) REFERENCES groups(id)")
    conn.execute("ALTER TABLE intakes ADD CONSTRAINT intakes_intake_type_id_fk FOREIGN KEY (intake_type_id) REFERENCES intake_types(id)")
    conn.execute("ALTER TABLE intakes ADD CONSTRAINT intakes_gender_id_fk FOREIGN KEY (gender_id) REFERENCES genders(id)")
  end
  
  def down
    drop_table :intakes
  end
end
