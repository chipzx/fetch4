class CreateGender < ActiveRecord::Migration
  def up
    conn = ActiveRecord::Base.connection
    create_table :genders do |t|
      t.string :name, :length => 1, :null => false
      t.text :description, :null => false
      t.integer :group_id, :null => false
      t.timestamps null: false
    end

    add_index :genders, [:name, :group_id], :unique => true
    add_index :genders, :group_id

    conn.execute("ALTER TABLE genders ALTER COLUMN created_at SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE genders ALTER COLUMN updated_at SET DATA TYPE timestamp with time zone")

    conn.execute("ALTER TABLE genders ADD CONSTRAINT genders_groups_fk FOREIGN KEY (group_id) REFERENCES groups(id)")

    conn.execute("INSERT INTO genders (name, description, group_id, created_at, updated_at) VALUES ('M', 'Male (Intact)', 0, now(), now())")
    conn.execute("INSERT INTO genders (name, description, group_id, created_at, updated_at) VALUES ('F', 'Female (Intact)', 0, now(), now())")
    conn.execute("INSERT INTO genders (name, description, group_id, created_at, updated_at) VALUES ('N', 'Neutered Male', 0, now(), now())")
    conn.execute("INSERT INTO genders (name, description, group_id, created_at, updated_at) VALUES ('S', 'Spayed Female', 0, now(), now())")
    conn.execute("INSERT INTO genders (name, description, group_id, created_at, updated_at) VALUES ('X', 'Unknown', 0, now(), now())")
  end

  def down
    drop_table :genders
  end
end
