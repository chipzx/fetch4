class AddKennelToOutcomes < ActiveRecord::Migration
  def change
    add_column :outcomes, :kennel_id, :integer
    add_index :outcomes, :kennel_id
  end
end
