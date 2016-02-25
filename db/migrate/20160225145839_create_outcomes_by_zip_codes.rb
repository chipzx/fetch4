class CreateOutcomesByZipCodes < ActiveRecord::Migration
  def change
    create_view :outcomes_by_zip_codes
  end
end
