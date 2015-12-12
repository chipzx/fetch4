class AddGroupIdToUser < ActiveRecord::Migration
  def up
    conn = ActiveRecord::Base.connection
    add_column :users, :group_id, :integer
    add_index :users, :group_id
    conn.execute("ALTER TABLE users ADD CONSTRAINT users_groups_fk FOREIGN KEY (group_id) REFERENCES groups(id)")
  end

  def down
    remove_column :users, :group_id
  end
end
