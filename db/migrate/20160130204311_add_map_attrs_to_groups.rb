class AddMapAttrsToGroups < ActiveRecord::Migration
  def up
    add_column :groups, :center_point_latitude, :float
    add_column :groups, :center_point_longitude, :float
    add_column :groups, :default_zoom_level, :integer
    add_column :groups, :max_intensity, :float
    add_column :groups, :display_name, :string
  end
  def down
    remove_column :groups, :center_point_latitude
    remove_column :groups, :center_point_longitude
    remove_column :groups, :default_zoom_level
    remove_column :groups, :max_intensity
    remove_column :groups, :display_name
  end
end
