class SetUserGroupIdNotNull < ActiveRecord::Migration
  def up
    change_column :users, :group_id, :integer, :null => false
  end
  def down
    change_column :users, :group_id, :integer, :null => true
  end
end
