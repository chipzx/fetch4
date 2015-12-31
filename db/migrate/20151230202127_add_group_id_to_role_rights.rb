class AddGroupIdToRoleRights < ActiveRecord::Migration
  def up
    conn = ActiveRecord::Base.connection
    add_column :role_rights, :group_id, :integer, :null => false
    remove_index :role_rights, [:role_id, :right_id]
    add_index :role_rights, [:role_id, :right_id, :group_id ], unique: true
    add_index :role_rights, :group_id
    conn.execute("ALTER TABLE role_rights ADD CONSTRAINT role_rights_groups_fk FOREIGN KEY (group_id) REFERENCES groups(id)")
  end

  def down
    remove_index :role_rights, [:role_id, :right_id, :group_id]
    add_index :role_rights, [:role_id, :right_id]
    remove_column :role_rights, :group_id
  end
end
