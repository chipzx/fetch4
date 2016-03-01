class TrackableAnimalTypes < ActiveRecord::Migration
  def up
    conn = ActiveRecord::Base.connection
    add_column :animal_types, :trackable_animal, :boolean, null: false, default: false
    conn.execute("UPDATE animal_types SET trackable_animal = true WHERE name IN ('Dog', 'Cat')")
  end
  def down
    remove_column :animal_types, :trackable_animal
  end
end
