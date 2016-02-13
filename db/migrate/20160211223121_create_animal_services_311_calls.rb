class CreateAnimalServices311Calls < ActiveRecord::Migration
  def up
    conn = ActiveRecord::Base.connection

    create_table :service_request_types do |t|
      t.string :name, :null => false
      t.string :standard_name, :null => false
      t.string :description
      t.integer :group_id, :null => false
      t.timestamps null: false
    end

    add_index :service_request_types, [ :name, :group_id ], :unique => true
   
    conn.execute("ALTER TABLE service_request_types ADD CONSTRAINT service_request_types_group_id FOREIGN KEY (group_id) REFERENCES groups(id)")


    create_table :service_request_status_types do |t|
      t.string :name, :null => false
      t.string :standard_name, :null => false
      t.string :description
      t.integer :group_id, :null => false
      t.timestamps null: false
    end

    add_index :service_request_status_types, [ :name, :group_id ], :unique => true

    conn.execute("ALTER TABLE service_request_status_types ADD CONSTRAINT service_request_status_types_group_id FOREIGN KEY (group_id) REFERENCES groups(id)")


    create_table :animal_services311_calls do |t|
      t.string :service_request_id, :null => false
      t.integer :group_id, :null => false
      t.integer :service_request_type_id, :null => false
      t.string :owning_department
      t.string :method_received
      t.integer :service_request_status_type_id, :null => false
      t.timestamp :status_change_date, :null => false 
      t.timestamp :date_opened, :null => false
      t.timestamp :last_updated, :null => false
      t.timestamp :date_closed
      t.string :service_request_location
      t.integer :address_id
      t.string :jurisdiction
      t.string :jurisdiction_name
      t.string :map_page
      t.string :map_tile
      t.integer :fiscal_year
      t.timestamps null: false
    end

    add_index :animal_services311_calls, [ :service_request_id, :group_id ], :name => 'anml_srvcs_srvc_req_id_group', :unique => true

    add_index :animal_services311_calls, :group_id

    add_index :animal_services311_calls, [ :service_request_type_id, :group_id ], :name => 'animal_service_311_calls_sr_type_group'

    add_index :animal_services311_calls, [ :service_request_status_type_id, :group_id ], :name => 'anml_srvcs_311_calls_sr_status_type_group'

    add_index :animal_services311_calls, [ :address_id, :group_id ], :name => 'anml_srvcs_311_calls_addr_id_group' 

    add_index :animal_services311_calls, :date_opened

    add_index :animal_services311_calls, :date_closed

    add_index :animal_services311_calls, :jurisdiction


    conn.execute("ALTER TABLE animal_services311_calls ADD CONSTRAINT animal_services311_group_id_fk FOREIGN KEY (group_id) REFERENCES groups(id)")

    conn.execute("ALTER TABLE animal_services311_calls ADD CONSTRAINT animal_services311_sr_type_id_fk FOREIGN KEY (service_request_type_id) REFERENCES service_request_types(id)")

    conn.execute("ALTER TABLE animal_services311_calls ADD CONSTRAINT animal_services311_sr_status_type_id_fk FOREIGN KEY (service_request_status_type_id) REFERENCES service_request_status_types(id)")

    conn.execute("ALTER TABLE animal_services311_calls ADD CONSTRAINT animal_services311_address_id_fk FOREIGN KEY (address_id) REFERENCES addresses(id)")

    conn.execute("INSERT INTO service_request_types (name, standard_name, group_id, created_at, updated_at) VALUES ('Dead Bird', 'Dead Bird', 0, now(), now())")
    conn.execute("INSERT INTO service_request_types (name, standard_name, group_id, created_at, updated_at) VALUES ('Animal Roadside Sales', 'Animal Roadside Sales', 0, now(),now())")
    conn.execute("INSERT INTO service_request_types (name, standard_name, group_id, created_at, updated_at) VALUES ('Animal Trapped in Storm Drain', 'Animal Trapped in Storm, Drain', 0, now(), now())")
    conn.execute("INSERT INTO service_request_types (name, standard_name, group_id, created_at, updated_at) VALUES ('Animal - Proper Care', 'Animal Proper Care', 0, now(), now())")
    conn.execute("INSERT INTO service_request_types (name, standard_name, group_id, created_at, updated_at) VALUES ('Wildlife Exposure', 'Wildlife Exposure', 0, now(), now())")
    conn.execute("INSERT INTO service_request_types (name, standard_name, group_id, created_at, updated_at) VALUES ('Dangerous/Vicious Dog Investigation', 'Dangerous Dog Investigation', 0, now(), now())")
    conn.execute("INSERT INTO service_request_types (name, standard_name, group_id, created_at, updated_at) VALUES ('Injured / Sick Animal', 'Injured Animal', 0, now(), now())")
    conn.execute("INSERT INTO service_request_types (name, standard_name, group_id, created_at, updated_at) VALUES ('Loose Animal Not Dog', 'Loose Animal Not Dog', 0, now(), now())")
    conn.execute("INSERT INTO service_request_types (name, standard_name, group_id, created_at, updated_at) VALUES ('Animal Control - Assistance Request', 'Assistance Request', 0, now(), now())")
    conn.execute("INSERT INTO service_request_types (name, standard_name, group_id, created_at, updated_at) VALUES ('Found Animal - Pick Up', 'Found Animal - Pick Up', 0, now(), now())")
    conn.execute("INSERT INTO service_request_types (name, standard_name, group_id, created_at, updated_at) VALUES ('Bat Complaint', 'Bat Complaint', 0, now(), now())")
    conn.execute("INSERT INTO service_request_types (name, standard_name, group_id, created_at, updated_at) VALUES ('Coyote Complaints', 'Coyote Complaints', 0, now(), now())")
    conn.execute("INSERT INTO service_request_types (name, standard_name, group_id, created_at, updated_at) VALUES ('Loose Dog', 'Loose Dog', 0, now(), now())")
    conn.execute("INSERT INTO service_request_types (name, standard_name, group_id, created_at, updated_at) VALUES ('Dangerous Animal - Except Dogs', 'Dangerous Animal - Except Dogs', 0, now(), now())")
    conn.execute("INSERT INTO service_request_types (name, standard_name, group_id, created_at, updated_at) VALUES ('Animal In Vehicle', 'Animal In Vehicle', 0, now(), now())")
    conn.execute("INSERT INTO service_request_types (name, standard_name, group_id, created_at, updated_at) VALUES ('Animal Bite', 'Animal Bite', 0, now(), now())")
    conn.execute("INSERT INTO service_request_types (name, standard_name, group_id, created_at, updated_at) VALUES ('Found Animal Report - Keep', 'Found Animal Report - Keep', 0, now(), now())")

    conn.execute("INSERT INTO service_request_status_types (name, standard_name, group_id, created_at, updated_at) VALUES ('Open', 'Open', 0, now(), now())")
    conn.execute("INSERT INTO service_request_status_types (name, standard_name, group_id, created_at, updated_at) VALUES ('Closed', 'Closed', 0, now(), now())")
    conn.execute("INSERT INTO service_request_status_types (name, standard_name, group_id, created_at, updated_at) VALUES ('Duplicate (open)', 'Duplicate (open)', 0, now(), now())")
    conn.execute("INSERT INTO service_request_status_types (name, standard_name, group_id, created_at, updated_at) VALUES ('Incomplete', 'Incomplete', 0, now(), now())")
    conn.execute("INSERT INTO service_request_status_types (name, standard_name, group_id, created_at, updated_at) VALUES ('New', 'New', 0, now(), now())")
    conn.execute("INSERT INTO service_request_status_types (name, standard_name, group_id, created_at, updated_at) VALUES ('Duplicate (closed)', 'Duplicate (closed)', 0, now(), now())")
    conn.execute("INSERT INTO service_request_status_types (name, standard_name, group_id, created_at, updated_at) VALUES ('Work In Progress', 'Work In Progress', 0, now(), now())")
    conn.execute("INSERT INTO service_request_status_types (name, standard_name, group_id, created_at, updated_at) VALUES ('Closed -Incomplete Information', 'Closed -Incomplete Information', 0, now(), now())")
  end

  def down
    drop_table :animal_services311_calls
    drop_table :service_request_status_types
    drop_table :service_request_types
  end
end
