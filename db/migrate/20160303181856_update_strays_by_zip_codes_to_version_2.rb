class UpdateStraysByZipCodesToVersion2 < ActiveRecord::Migration
  def change
    update_view :strays_by_zip_codes, version: 2, revert_to_version: 1
  end
end
