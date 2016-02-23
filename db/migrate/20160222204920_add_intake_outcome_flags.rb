class AddIntakeOutcomeFlags < ActiveRecord::Migration
  def up
    add_column :intake_types, :count_as_intake, :boolean, :null => false, :default => true
    add_column :outcome_types, :count_as_outcome, :boolean, :null => false, :default => true
  end

  def down
    remove_column :intake_types, :count_as_intake
    remove_column :outcome_types, :count_as_outcome
  end
end
