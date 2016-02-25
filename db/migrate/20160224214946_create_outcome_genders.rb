class CreateOutcomeGenders < ActiveRecord::Migration
  def change
    create_view :outcome_genders
  end
end
