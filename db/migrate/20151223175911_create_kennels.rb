class CreateKennels < ActiveRecord::Migration
  def up
    conn = ActiveRecord::Base.connection

    create_table :kennel_types do |t|
      t.string :name, :null => false
      t.text :description
      t.integer :group_id, :null => false
      t.timestamps null: false
    end

    add_index :kennel_types, [ :name, :group_id ], :unique => true
    add_index :kennel_types, :group_id

    conn.execute("ALTER TABLE kennel_types ALTER COLUMN created_at SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE kennel_types ALTER COLUMN updated_at SET DATA TYPE timestamp with time zone")

    conn.execute("ALTER TABLE kennel_types ADD CONSTRAINT kennel_types_groups_fk FOREIGN KEY (group_id) REFERENCES groups(id)")
    conn.execute("INSERT INTO kennel_types (name, description, group_id, created_at, updated_at) VALUES ('Standard Kennel', 'Default kennel type', 0, now(), now())")    

    create_table :kennels do |t|
      t.string :name, :null => false
      t.string :building
      t.integer :kennel_type_id, :null => false
      t.integer :max_occupancy, :null => false, :default => 1
      t.boolean :full_name, :null => false, :default => false
      t.boolean :is_onsite, :null => false, :default => true
      t.boolean :is_public, :null => false, :default => true
      t.boolean :is_permanent, :null => false, :default => true
      t.boolean :is_available, :null => false, :default => true
      t.integer :group_id, :null => false
      t.timestamps null: false
    end

    add_index :kennels, [:name, :building, :group_id], :unique => true
    add_index :kennels, :group_id

    conn.execute("ALTER TABLE kennels ALTER COLUMN created_at SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE kennels ALTER COLUMN updated_at SET DATA TYPE timestamp with time zone")
    
    conn.execute("ALTER TABLE kennels ADD CONSTRAINT kennels_kennel_types FOREIGN KEY (kennel_type_id) REFERENCES kennel_types(id)")

    conn.execute("ALTER TABLE kennels ADD CONSTRAINT kennels_groups FOREIGN KEY (group_id) REFERENCES groups(id)")
  end

  def down
    drop_table :kennels
    drop_table :kennel_types
  end

end
