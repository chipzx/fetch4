class CreateOutcomePostalCodeRanks < ActiveRecord::Migration
  def change
    create_view :outcome_postal_code_ranks
  end
end
