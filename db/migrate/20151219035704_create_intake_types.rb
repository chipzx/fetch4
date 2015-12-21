class CreateIntakeTypes < ActiveRecord::Migration
  def up
    conn = ActiveRecord::Base.connection

    create_table :intake_types do |t|
      t.string :name, :null => false
      t.integer :group_id, :null => false
      t.text :description
      t.timestamps
    end

    # Add default intake types
    conn.execute("INSERT INTO intake_types (name, group_id, description, created_at, updated_at) VALUES ('Stray', 0, 'Animal found or turned in as stray', now(), now())")
    conn.execute("INSERT INTO intake_types (name, group_id, description, created_at, updated_at) VALUES ('Owner Surrender', 0, 'Animal surrendered by former owner', now(), now())")
    conn.execute("INSERT INTO intake_types (name, group_id, description, created_at, updated_at) VALUES ('Public Assist', 0, 'Animal turned in by legal authority', now(), now())")
  end

  def down
    drop_table :intake_types
  end
end
