class RemoveStandardName < ActiveRecord::Migration
  def up
    remove_column :service_request_types, :standard_name
    remove_column :service_request_status_types, :standard_name
  end
  def down
    add_column :service_request_types, :standard_name, :varchar
    add_column :service_request_status_types, :standard_name, :varchar
  end
end
