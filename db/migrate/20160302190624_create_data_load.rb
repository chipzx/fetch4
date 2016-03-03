class CreateDataLoad < ActiveRecord::Migration
  def up

    conn = ActiveRecord::Base.connection

    create_table :data_load_types do |t|
      t.string :name, null: false
      t.text    :description
      t.timestamps null: false
    end

    add_index :data_load_types, :name, unique: true

    create_table :data_loads do |t|
      t.integer :group_id, null: false
      t.string :data_path, null: false
      t.string :archive_dir_path
      t.integer :data_load_type_id, null: false
      t.string :load_class, null: false
      t.timestamps null: false
    end

    add_index :data_loads, [ :data_load_type_id, :group_id ], unique: true
    add_index :data_loads, :group_id

    create_table :data_load_logs do |t|
      t.integer :data_load_id, null: false
      t.integer :group_id, null: false
      t.timestamp :date_loaded, null: false
      t.timestamp :data_as_of, null: false
      t.integer :total_rows, default: 0
      t.integer :total_added, default: 0
      t.integer :total_updated, default: 0
      t.integer :total_outcomes, default: 0
      t.integer :total_errors, default: 0
      t.boolean :was_successful
      t.timestamp :start_time, null: false
      t.timestamp :end_time
      t.timestamps null: false
    end

    add_index :data_load_logs, [:data_load_id, :group_id], unique: true
    add_index :data_load_logs, :group_id
    add_index :data_load_logs, :date_loaded
    add_index :data_load_logs, :start_time

    conn.execute("ALTER TABLE data_load_types ALTER COLUMN created_at SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE data_load_types ALTER COLUMN updated_at SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE data_loads ALTER COLUMN created_at SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE data_loads ALTER COLUMN updated_at SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE data_load_logs ALTER COLUMN created_at SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE data_load_logs ALTER COLUMN updated_at SET DATA TYPE timestamp with time zone")

    conn.execute("ALTER TABLE data_loads ADD CONSTRAINT data_load_data_load_type_id_fk FOREIGN KEY (data_load_type_id) REFERENCES data_load_types(id)")
    conn.execute("ALTER TABLE data_loads ADD CONSTRAINT data_load_group_id_fk FOREIGN KEY (group_id) REFERENCES groups(id)")
    conn.execute("ALTER TABLE data_load_logs ADD CONSTRAINT data_load_logs_data_load_id_fk FOREIGN KEY (data_load_id) REFERENCES data_loads(id)")
    conn.execute("ALTER TABLE data_load_logs ADD CONSTRAINT data_load_logs_group_id_fk FOREIGN KEY (group_id) REFERENCES groups(id)")

    conn.execute("INSERT INTO data_load_types (name, description, created_at, updated_at) VALUES ('animals', 'Import of information about animals under care', now(), now())")
    conn.execute("INSERT INTO data_load_types (name, description, created_at, updated_at) VALUES ('intakes', 'Import of information about animal intakes', now(), now())")
    conn.execute("INSERT INTO data_load_types (name, description, created_at, updated_at) VALUES ('outcomes', 'Import of information about animal outcomes', now(), now())")
    conn.execute("INSERT INTO data_load_types (name, description, created_at, updated_at) VALUES ('service_requests', 'Import of information about 311 calls to animal services', now(), now())")
  end

  def down
    drop_table :data_load_logs
    drop_table :data_loads
    drop_table :data_load_types
  end
end
