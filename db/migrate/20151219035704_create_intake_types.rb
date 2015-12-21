class CreateIntakeTypes < ActiveRecord::Migration
  def up
    conn = ActiveRecord::Base.connection

    create_table :intake_types do |t|
      t.string :name, :null => false
      t.integer :group_id, :null => false
      t.text :description
      t.timestamps null: false
    end

    add_index :intake_types, [ :group_id, :name ], :unique => true
    add_index :intake_types, :name

    # Add default intake types
    conn.execute("INSERT INTO intake_types (name, group_id, description, created_at, updated_at) VALUES ('Stray', 0, 'Stray animal brought to animal care facility', now(), now())")
    conn.execute("INSERT INTO intake_types (name, group_id, description, created_at, updated_at) VALUES ('Owner Surrender', 0, 'Animal surrendered by former owner to animal care facility', now(), now())")
    conn.execute("INSERT INTO intake_types (name, group_id, description, created_at, updated_at) VALUES ('Transfer', 0, 'Animal transferred from another animal care facility', now(), now())")
    conn.execute("INSERT INTO intake_types (name, group_id, description, created_at, updated_at) VALUES ('Public Assist', 0, 'Animal turned in by legal authority to animal care facility', now(), now())")
    conn.execute("INSERT INTO intake_types (name, group_id, description, created_at, updated_at) VALUES ('Wildlife', 0, 'Wildlife Intake request', now(), now())")
    conn.execute("INSERT INTO intake_types (name, group_id, description, created_at, updated_at) VALUES ('Euthanasia Request', 0, 'Former owner requests humane euthanasia', now(), now())")
    conn.execute("INSERT INTO intake_types (name, group_id, description, created_at, updated_at) VALUES ('Other', 0, 'Not a stray, owner surrender, transfer, public assist, or euthanasia request', now(), now())")
    conn.execute("INSERT INTO intake_types (name, group_id, description, created_at, updated_at) VALUES ('Unknown', 0, 'Intake type not yet determined', now(), now())")
  end

  def down
    drop_table :intake_types
  end
end
