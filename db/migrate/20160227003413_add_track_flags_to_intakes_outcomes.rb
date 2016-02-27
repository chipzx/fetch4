class AddTrackFlagsToIntakesOutcomes < ActiveRecord::Migration
  def up
    add_column :intake_types, :trackable_intake, :boolean, :null => false, :default => true
    add_column :intake_types, :live_intake, :boolean, :null => false, :default => true
    add_column :outcome_types, :trackable_outcome, :boolean, :null => false, :default => true
    add_column :outcome_types, :live_outcome, :boolean, :null => false, :default => true
  end

  def down
    remove_column :intake_types, :trackable_intake
    remove_column :intake_types, :live_intake
    remove_column :outcome_types, :trackable_outcome
    remove_column :outcome_types, :live_outcome
  end
end
