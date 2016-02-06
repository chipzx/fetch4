class AddFiscalYearFields < ActiveRecord::Migration
  def up
    add_column :groups, :fiscal_year_start, :string, :null => false, :default => 'January 1'
    add_column :groups, :fiscal_year_end, :string, :null => false, :default => 'December 31'
    add_column :outcomes, :fiscal_year, :integer
  end
  def down
    remove_column :groups, :fiscal_year_start
    remove_column :groups, :fiscal_year_end
    remove_column :outcomes, :fiscal_year
  end
end
