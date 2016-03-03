class CreateImportAnimals < ActiveRecord::Migration
  def up
    conn = ActiveRecord::Base.connection
    create_table :animal_imports do |t|
      t.integer :group_id, null: false
      t.string :animal_type, null: false
      t.integer :animal_type_id
      t.integer :animal_id, null: false
      t.string :name
      t.string :kennel
      t.integer :kennel_id
      t.timestamp :intake_date
      t.string :intake_type
      t.integer :intake_type_id
      t.string :gender
      t.integer :gender_id
      t.string :breed
      t.string :coloring
      t.float :weight
      t.timestamp :dob
      t.boolean :dob_known
      t.text :description
      t.timestamp :date_imported, null: false
      t.timestamp :data_as_of, null: false
      t.timestamps null: false
    end

    add_index :animal_imports, [:animal_id, :group_id], unique: true
    add_index :animal_imports, :group_id
    add_index :animal_imports, :data_as_of
    
    conn.execute("ALTER TABLE animal_imports ALTER COLUMN intake_date SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE animal_imports ALTER COLUMN dob SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE animal_imports ALTER COLUMN date_imported SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE animal_imports ALTER COLUMN data_as_of SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE animal_imports ALTER COLUMN created_at SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE animal_imports ALTER COLUMN updated_at SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE animal_imports ADD COLUMN age interval")
   
    conn.execute("ALTER TABLE animal_imports ADD CONSTRAINT animal_imports_group_id_fk FOREIGN KEY (group_id) REFERENCES groups(id)")
    conn.execute("ALTER TABLE animal_imports ADD CONSTRAINT animal_imports_animal_type_id_fk FOREIGN KEY (animal_type_id) REFERENCES animal_types(id)")
    conn.execute("ALTER TABLE animal_imports ADD CONSTRAINT animal_imports_intake_type_id_fk FOREIGN KEY (intake_type_id) REFERENCES intake_types(id)")
    conn.execute("ALTER TABLE animal_imports ADD CONSTRAINT animal_imports_kennel_id_fk FOREIGN KEY (kennel_id) REFERENCES kennels(id)")
    conn.execute("ALTER TABLE animal_imports ADD CONSTRAINT animal_imports_gender_id_fk FOREIGN KEY (gender_id) REFERENCES genders(id)")

  end

  def down
    drop_table :animal_imports
  end
end
