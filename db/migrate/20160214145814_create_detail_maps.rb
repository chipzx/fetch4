class CreateDetailMaps < ActiveRecord::Migration
  def up
    conn = ActiveRecord::Base.connection

    create_table :map_types do |t|
      t.string :name, :null => false
      t.text :description
      t.timestamps null: false
    end

    add_index :map_types, :name, :unique => true

    create_table :detail_maps do |t|
      t.string :map_name, :null => false
      t.integer :group_id, :null => false
      t.float :center_point_latitude, :null => false
      t.float :center_point_longitude, :null => false
      t.float :radius, :null => false, :precison => 4, :scale => 2
      t.float :max_intensity, :null => false, :default => 1.0
      t.integer :zoom_level, :null => false, :default => 11
      t.integer :map_type_id, :null => false
      t.timestamps null: false
    end

    add_index :detail_maps, [ :map_name, :group_id ], :unique => true
    add_index :detail_maps, :group_id
    
    conn.execute("ALTER TABLE map_types ALTER COLUMN created_at SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE map_types ALTER COLUMN updated_at SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE detail_maps ALTER COLUMN created_at SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE detail_maps ALTER COLUMN updated_at SET DATA TYPE timestamp with time zone")

    conn.execute("ALTER TABLE detail_maps ADD CONSTRAINT detail_maps_group_id_fk FOREIGN KEY (group_id) REFERENCES groups(id)")
    conn.execute("ALTER TABLE detail_maps ADD CONSTRAINT detail_maps_map_type_id_fk FOREIGN KEY (map_type_id) REFERENCES groups(id)")
  end

  def down
    drop_table :detail_maps
    drop_table :map_types
  end
end
