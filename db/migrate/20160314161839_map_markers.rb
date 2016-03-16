class MapMarkers < ActiveRecord::Migration
  def up
    conn = ActiveRecord::Base.connection
    create_table :map_markers do |t|
      t.string :name, null: false
      t.integer :group_id, null: false
      t.string :icon_name, null: false, default: 'Marker'
      t.text :description
      t.timestamps null: false
    end

    add_index :map_markers, [ :name, :group_id ], unique: true
    add_index :map_markers, :group_id

    conn.execute("ALTER TABLE map_markers ALTER COLUMN created_at SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE map_markers ALTER COLUMN updated_at SET DATA TYPE timestamp with time zone")

    conn.execute("ALTER TABLE map_markers ADD CONSTRAINT map_markers_group_id_fk FOREIGN KEY (group_id) REFERENCES groups(id)")
    
  end

  def down
    drop_table :map_markers
  end
end
