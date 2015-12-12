class CreateAnimalTypes < ActiveRecord::Migration
  def up
    conn = ActiveRecord::Base.connection
    create_table :animal_types do |t|
      t.string :name, :null => false
      t.integer :group_id, :null => false
      t.text :description, :null => false
      t.timestamps null: false
    end

    add_index :animal_types, [ :group_id, :name ], :unique => true
    add_index :animal_types, :name

    conn.execute("INSERT INTO animal_types (name, group_id, description, created_at, updated_at) VALUES ('Dog', 0, 'All canines', now(), now())")
    conn.execute("INSERT INTO animal_types (name, group_id, description, created_at, updated_at) VALUES ('Cat', 0, 'All felines', now(), now())")
  end

  def down
    drop_table :animal_types
  end

end
