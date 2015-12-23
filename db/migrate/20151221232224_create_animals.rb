class CreateAnimals < ActiveRecord::Migration
  def up
    conn = ActiveRecord::Base.connection

    create_table :animals do |t|
      t.integer :animal_type_id, :null => false
      t.string :anumber, :null => false
      t.string :name
      t.integer :kennel_id
      t.integer :gender_id
      t.string :breed
      t.string :coloring
      t.string :weight
      t.timestamp :dob
      t.boolean :dob_known
      t.timestamp :intake_date
      t.integer :intake_type_id, :null => false, :default => 'Unknown'
      t.text :description
      t.integer :group_id, :null => false
      t.decimal :weight
      t.string :microchip_number

      t.timestamps null: false
    end

    add_index :animals, [:anumber, :group_id], :unique => true
    add_index :animals, :name
    add_index :animals, :group_id
    add_index :animals, :kennel_id
    add_index :animals, :intake_type_id
    add_index :animals, :breed
    add_index :animals, :microchip_number

    conn.execute("ALTER TABLE animals ADD CONSTRAINT animals_groups_fk FOREIGN KEY (group_id) REFERENCES groups(id)")
    conn.execute("ALTER TABLE animals ADD CONSTRAINT animals_animal_types_fk FOREIGN KEY (animal_type_id) REFERENCES animal_types(id)")
    conn.execute("ALTER TABLE animals ADD CONSTRAINT animals_intake_types_fk FOREIGN KEY (intake_type_id) REFERENCES intake_types(id)")
  end

  def down
    drop_table :animals
  end

end
