class ChangeGroupFiscalYearFields < ActiveRecord::Migration
  def up
    add_column :groups, :fiscal_year_start_quarter, :integer, null: false, default: 1
    remove_column :groups, :fiscal_year_start
    remove_column :groups, :fiscal_year_end
  end
  def down
    remove_column :groups, :fiscal_year_start_quarter
    add_column :groups, :fiscal_year_start, :string, null: false, default: 'January 1'
    add_column :groups, :fiscal_year_end, :string, null: false, default: 'December 31'
  end
end
