class AddGeoFieldsToAddress < ActiveRecord::Migration
  def up
    add_column :addresses, :geo_quality_code, :string
    add_column :addresses, :feature_type, :string
    add_column :addresses, :partial_match, :boolean
    add_column :addresses, :valid_address, :boolean
    add_column :addresses, :full_location, :text

    add_index :addresses, :geo_quality_code
    add_index :addresses, :full_location
  end
  def down
    remove_column :addresses, :geo_quality_code
    remove_column :addresses, :feature_type
    remove_column :addresses, :partial_match
    remove_column :addresses, :valid_address
    remove_column :addresses, :full_location
  end
end
