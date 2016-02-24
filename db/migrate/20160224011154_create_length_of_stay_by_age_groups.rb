class CreateLengthOfStayByAgeGroups < ActiveRecord::Migration
  def change
    create_view :length_of_stay_by_age_groups
  end
end
