class CreateStraysByZipCodes < ActiveRecord::Migration
  def change
    create_view :strays_by_zip_codes
  end
end
