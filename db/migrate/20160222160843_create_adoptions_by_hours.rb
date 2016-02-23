class CreateAdoptionsByHours < ActiveRecord::Migration
  def change
    create_view :adoptions_by_hours
  end
end
