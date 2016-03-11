class ColorGroupMap < ActiveRecord::Migration
  def up 
    conn = ActiveRecord::Base.connection
    create_table :color_group_mappings do |t|
      t.string :color_group, null: false
      t.string :coloring, null: false
      t.integer :precedence, null: false, default: 2
      t.timestamps null: false
    end

    add_index :color_group_mappings, :color_group
    add_index :color_group_mappings, :coloring

    conn.execute("ALTER TABLE color_group_mappings ALTER COLUMN created_at SET DATA TYPE TIMESTAMP WITH TIME ZONE")
    conn.execute("ALTER TABLE color_group_mappings ALTER COLUMN updated_at SET DATA TYPE TIMESTAMP WITH TIME ZONE")
    conn.execute("ALTER TABLE color_group_mappings ALTER COLUMN created_at SET DEFAULT now()")
    conn.execute("ALTER TABLE color_group_mappings ALTER COLUMN updated_at SET DEFAULT now()")

    conn.execute("INSERT INTO color_group_mappings (color_group, coloring) VALUES ('Black', 'black%')")
    conn.execute("INSERT INTO color_group_mappings (color_group, coloring) VALUES ('Black', 'charcoal%')")
    conn.execute("INSERT INTO color_group_mappings (color_group, coloring) VALUES ('Blk', 'blk%')")
    conn.execute("INSERT INTO color_group_mappings (color_group, coloring) VALUES ('Brown', 'brown%')")
    conn.execute("INSERT INTO color_group_mappings (color_group, coloring) VALUES ('Brown', 'brn%')")
    conn.execute("INSERT INTO color_group_mappings (color_group, coloring) VALUES ('Brown', 'bronze%')")
    conn.execute("INSERT INTO color_group_mappings (color_group, coloring) VALUES ('Brown', 'chocolate%')")
    conn.execute("INSERT INTO color_group_mappings (color_group, coloring) VALUES ('Yellow or Tan', 'yellow%')")
    conn.execute("INSERT INTO color_group_mappings (color_group, coloring) VALUES ('Yellow or Tan', 'blond%')")
    conn.execute("INSERT INTO color_group_mappings (color_group, coloring) VALUES ('Yellow or Tan', 'butterscotch%')")
    conn.execute("INSERT INTO color_group_mappings (color_group, coloring) VALUES ('Yellow or Tan', 'tan%')")
    conn.execute("INSERT INTO color_group_mappings (color_group, coloring) VALUES ('Yellow or Tan', 'fawn%')")
    conn.execute("INSERT INTO color_group_mappings (color_group, coloring) VALUES ('Yellow or Tan', 'gold%')")
    conn.execute("INSERT INTO color_group_mappings (color_group, coloring) VALUES ('Yellow or Tan', 'mustard%')")
    conn.execute("INSERT INTO color_group_mappings (color_group, coloring) VALUES ('Gray', 'gray%')")
    conn.execute("INSERT INTO color_group_mappings (color_group, coloring) VALUES ('Gray', 'grey%')")
    conn.execute("INSERT INTO color_group_mappings (color_group, coloring) VALUES ('Gray', 'liver%')")
    conn.execute("INSERT INTO color_group_mappings (color_group, coloring) VALUES ('Gray', 'silver%')")
    conn.execute("INSERT INTO color_group_mappings (color_group, coloring) VALUES ('Gray', 'smoke%')")
    conn.execute("INSERT INTO color_group_mappings (color_group, coloring) VALUES ('Blue', 'blue%')")
    conn.execute("INSERT INTO color_group_mappings (color_group, coloring) VALUES ('Red', 'red%')")
    conn.execute("INSERT INTO color_group_mappings (color_group, coloring) VALUES ('Red', 'apricot%')")
    conn.execute("INSERT INTO color_group_mappings (color_group, coloring) VALUES ('Red', 'Lavender%')")
    conn.execute("INSERT INTO color_group_mappings (color_group, coloring) VALUES ('Red', 'Lilac%')")
    conn.execute("INSERT INTO color_group_mappings (color_group, coloring) VALUES ('Red', 'Orange%')")
    conn.execute("INSERT INTO color_group_mappings (color_group, coloring) VALUES ('Red', 'Rust%')")
    conn.execute("INSERT INTO color_group_mappings (color_group, coloring) VALUES ('White', 'white%')")
    conn.execute("INSERT INTO color_group_mappings (color_group, coloring) VALUES ('White', 'buff%')")
    conn.execute("INSERT INTO color_group_mappings (color_group, coloring) VALUES ('White', 'beige%')")
    conn.execute("INSERT INTO color_group_mappings (color_group, coloring) VALUES ('White', 'cream%')")
    conn.execute("INSERT INTO color_group_mappings (color_group, coloring) VALUES ('White', 'sable%')")
    conn.execute("INSERT INTO color_group_mappings(color_group, coloring) VALUES ('Other', 'wheaten')")
    conn.execute("INSERT INTO color_group_mappings(color_group, coloring) VALUES ('Other', 'tricolor')")
    conn.execute("INSERT INTO color_group_mappings (color_group, coloring, precedence) VALUES ('Brindle', '%brindle%',1)")
  end

  def down
    drop_table :color_group_mappings
  end
end
