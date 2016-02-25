class CreateIntakeGenders < ActiveRecord::Migration
  def change
    create_view :intake_genders
  end
end
