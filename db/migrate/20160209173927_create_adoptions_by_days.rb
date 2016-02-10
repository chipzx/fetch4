class CreateAdoptionsByDays < ActiveRecord::Migration
  def change
    create_view :adoptions_by_days
  end
end
