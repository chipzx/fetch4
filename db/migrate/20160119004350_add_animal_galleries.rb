class AddAnimalGalleries < ActiveRecord::Migration
  def up
    conn = ActiveRecord::Base.connection
    create_table :animal_galleries do |t|
      t.integer :animal_id, :null => false
      t.boolean :primary_image, :null => false, :default => false
      t.timestamps null: false
    end

    add_attachment :animal_galleries, :photo

    add_index :animal_galleries, :animal_id

    conn.execute("ALTER TABLE animal_galleries ADD CONSTRAINT animal_animal_galleries_fk FOREIGN KEY (animal_id) REFERENCES animals(id)")
  end

  def down
    drop_table :animal_galleries
  end
end
