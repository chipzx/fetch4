class Dashboard < ActiveRecord::Migration
  def change
    create_table :dashboards do |t|
      t.integer :group_id, null: false
      t.string :name, null: false, default: 'Default'
      t.string :description
      t.string :default_time_period, null: false, default: 'monthly'
    end
  end
end
