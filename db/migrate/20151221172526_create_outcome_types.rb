class CreateOutcomeTypes < ActiveRecord::Migration
  def up
    conn = ActiveRecord::Base.connection
    create_table :outcome_types do |t|
      t.string :name, :null => false
      t.text :description
      t.integer :group_id, :null => false
      t.timestamps null: false
    end

    add_index :outcome_types, [:group_id, :name], :unique => true
    add_index :outcome_types, :name

    conn.execute("ALTER TABLE outcome_types ADD CONSTRAINT outcome_types_groups_fk FOREIGN KEY group_id REFERENCES groups(id)")

    conn.execute("INSERT INTO outcome_types (name, description, group_id, created_at, updated_at) VALUES ('Adoption', 'Animal adopted by customer', 0, now(), now())")
    conn.execute("INSERT INTO outcome_types (name, description, group_id, created_at, updated_at) VALUES ('Return to Owner', 'Animal returned to owner', 0, now(), now())")
    conn.execute("INSERT INTO outcome_types (name, description, group_id, created_at, updated_at) VALUES ('Transfer', 'Animal transferred to another animal care facility', 0, now(), now())")
    conn.execute("INSERT INTO outcome_types (name, description, group_id, created_at, updated_at) VALUES ('Euthanized', 'Animal euthanized for medical or behavioral reasons', 0, now(), now())")
    conn.execute("INSERT INTO outcome_types (name, description, group_id, created_at, updated_at) VALUES ('Died', 'Animal died while under care', 0, now(), now())")
    conn.execute("INSERT INTO outcome_types (name, description, group_id, created_at, updated_at) VALUES ('Lost', 'Animal went missing while under care', 0, now(), now())")
    conn.execute("INSERT INTO outcome_types (name, description, group_id, created_at, updated_at) VALUES ('Unknown', 'Type of outcome not yet known', 0, now(), now())")
  end

  def down
    drop_table :outcome_types
  end
end
