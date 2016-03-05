class FixDataLoadLogsKey < ActiveRecord::Migration
  def up
    remove_index :data_load_logs, [:data_load_id, :group_id]
    add_index :data_load_logs, [:data_load_id, :start_time, :group_id], 
              name: 'data_load_logs_uidx', unique: true
  end
 
  def down
    add_index :data_load_logs, [:data_load_id, :group_id]
    remove_index :data_load_logs, name: 'data_load_logs_uidx'
  end
end
