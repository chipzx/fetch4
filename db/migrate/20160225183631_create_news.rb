class CreateNews < ActiveRecord::Migration
  def up
    conn = ActiveRecord::Base.connection

    create_table :news do |t|
      t.timestamp :published, :null => false
      t.string :headline, :null => false
      t.text :lead
      t.string :article_link
      t.boolean :visible, :null => false, :default => true
      t.timestamps null: false
    end
 
    add_index :news, [:published, :headline], :unique => true
    add_index :news, :headline

    conn.execute("ALTER TABLE news ALTER COLUMN published SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE news ALTER COLUMN created_at SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE news ALTER COLUMN updated_at SET DATA TYPE timestamp with time zone")
  end

  def down
    drop_table :news
  end
end
