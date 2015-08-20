class CreateAnimals < ActiveRecord::Migration
def change
    create_table :animals do |t|
      t.integer :atype_id, :null => false
      t.string :anumber, :null => false
      t.string :name
      t.integer :kennel_id
      t.integer :gender_id
      t.string :breed
      t.string :coloring
      t.string :weight
      t.timestamp :dob
      t.boolean :dob_known
      t.timestamp :intake_date
      t.integer :intake_type_id
      t.text :description
      t.integer :group_id, :null => false
      t.decimal :weight

      t.timestamps
    end

    add_index :animals, [:anumber, :group_id], :unique => true
    add_index :animals, :name
    add_index :animals, :group_id
  end
end
