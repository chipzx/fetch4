class UpdateAdoptionsByDaysToVersion2 < ActiveRecord::Migration
  def change
    update_view :adoptions_by_days, version: 2, revert_to_version: 1
  end
end
