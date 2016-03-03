class UpdateOutcomeGendersToVersion2 < ActiveRecord::Migration
  def change
    update_view :outcome_genders, version: 2, revert_to_version: 1
  end
end
