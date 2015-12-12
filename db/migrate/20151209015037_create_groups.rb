class CreateGroups < ActiveRecord::Migration
  def up
    conn = ActiveRecord::Base.connection
    create_table :groups do |t|
      t.string :name, :null => false
      t.string :time_zone, :null => false
      t.text :description
      t.timestamps null: false
    end
    add_index(:groups, :name, :unique => true)
    conn.execute("INSERT INTO groups (id, name, time_zone, description, created_at, updated_at) VALUES (0, 'root', 'UTC', 'FetchIT Root Admin', now(), now())")
  end

  def down
    drop_table :groups
  end

end
