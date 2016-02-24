class CreateOverallLengthOfStays < ActiveRecord::Migration
  def change
    create_view :overall_length_of_stays
  end
end
