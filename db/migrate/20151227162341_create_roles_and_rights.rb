class CreateRolesAndRights < ActiveRecord::Migration
  def up
    conn = ActiveRecord::Base.connection
    create_table :roles do |t|
      t.string :name, :null => false
      t.text :description, :null => false
      t.integer :group_id, :null => false
      t.boolean :active, :null => false, :default => true
      t.timestamps null: false
    end

    add_index :roles, [:name, :group_id], :unique => true
    add_index :roles, :group_id

    conn.execute("ALTER TABLE roles ADD CONSTRAINT roles_groups_fk FOREIGN KEY (group_id) REFERENCES groups(id)")

    conn.execute("ALTER TABLE roles ALTER COLUMN created_at SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE roles ALTER COLUMN updated_at SET DATA TYPE timestamp with time zone")

    conn.execute("INSERT INTO roles (name, description, group_id, created_at, updated_at) VALUES ('Admin', 'Administrator role with all rights', 0, now(), now())")
    conn.execute("INSERT INTO roles (name, description, group_id, created_at, updated_at) VALUES ('Guest', 'Guest user with limited read-only privileges', 0, now(), now())")

    create_table :rights do |t|
      t.string :resource, :null => false
      t.string :action, :null => false
      t.timestamps null: false
    end

    add_index :rights, [:resource, :action], :unique => true

    conn.execute("ALTER TABLE rights ALTER COLUMN created_at SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE rights ALTER COLUMN updated_at SET DATA TYPE timestamp with time zone")

    create_table :role_rights do |t|
      t.integer :role_id, :null => false
      t.integer :right_id, :null => false
      t.timestamps null: false
    end

    add_index :role_rights, [:role_id, :right_id], :unique => true
    add_index :role_rights, :right_id

    conn.execute("ALTER TABLE role_rights ADD CONSTRAINT role_rights_roles_fk FOREIGN KEY (role_id) REFERENCES roles(id)")
    conn.execute("ALTER TABLE role_rights ADD CONSTRAINT role_rights_rights_fk FOREIGN KEY (right_id) REFERENCES rights(id)")

    conn.execute("ALTER TABLE role_rights ALTER COLUMN created_at SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE role_rights ALTER COLUMN updated_at SET DATA TYPE timestamp with time zone")

    create_table :privileges do |t|
      t.integer :user_id, :null => false
      t.integer :right_id, :null => false
      t.integer :group_id, :null => false
      t.timestamps
    end

    add_index :privileges, [:user_id, :right_id], :unique => true
    add_index :privileges, :right_id
    add_index :privileges, :group_id

    conn.execute("ALTER TABLE privileges ADD CONSTRAINT privileges_users_fk FOREIGN KEY (user_id) REFERENCES users(id)")
    conn.execute("ALTER TABLE privileges ADD CONSTRAINT privileges_rights_fk FOREIGN KEY (right_id) REFERENCES rights(id)")
    conn.execute("ALTER TABLE privileges ADD CONSTRAINT privileges_groups_fk FOREIGN KEY (group_id) REFERENCES groups(id)")

    conn.execute("ALTER TABLE privileges ALTER COLUMN created_at SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE privileges ALTER COLUMN updated_at SET DATA TYPE timestamp with time zone")

    create_table :user_roles do |t|
      t.integer :user_id, :null => false
      t.integer :role_id, :null => false
      t.integer :group_id, :null => false
      t.timestamps null: false
    end

    add_index :user_roles, [:user_id, :role_id], :unique => true
    add_index :user_roles, :role_id
    add_index :user_roles, :group_id

    conn.execute("ALTER TABLE user_roles ADD CONSTRAINT user_roles_users_fk FOREIGN KEY (user_id) REFERENCES users(id)")
    conn.execute("ALTER TABLE privileges ADD CONSTRAINT user_roles_rights_fk FOREIGN KEY (right_id) REFERENCES rights(id)")
    conn.execute("ALTER TABLE privileges ADD CONSTRAINT user_roles_groups_fk FOREIGN KEY (group_id) REFERENCES groups(id)")

    conn.execute("ALTER TABLE user_roles ALTER COLUMN created_at SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE user_roles ALTER COLUMN updated_at SET DATA TYPE timestamp with time zone")

  end

  def down
    drop_table :user_roles
    drop_table :privileges
    drop_table :role_rights
    drop_table :rights
    drop_table :roles
  end
end
