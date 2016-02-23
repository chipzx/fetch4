class UpdateAdoptionsByDaysToVersion3 < ActiveRecord::Migration
  def change
    update_view :adoptions_by_days, version: 3, revert_to_version: 2
  end
end
