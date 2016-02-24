class LengthOfStay < ActiveRecord::Migration
  def up
    conn = ActiveRecord::Base.connection
    create_table :age_groups do |t|
      t.string :name, :null => false
      t.text :description
      t.timestamps null: false
    end

    add_index :age_groups, :name, unique: true

    create_table :breed_groups do |t|
      t.string :name, :null => false
      t.text :description
      t.timestamps null: false
    end

    add_index :breed_groups, :name, unique: true

    create_table :weight_groups do |t|
      t.string :name, :null => false
      t.text :description
      t.timestamps null: false
    end

    add_index :weight_groups, :name, unique: true

    create_table :color_groups do |t|
      t.string :name, :null => false
      t.text :description
      t.timestamps null: false
    end

    add_index :color_groups, :name, unique: true

    create_table  :length_of_stays do |t|
      t.integer   :outcome_id, :null => false
      t.string    :animal_id, :null => false
      t.integer   :group_id, :null => false
      t.string    :animal_type, :null => false
      t.string    :gender, :null => false
      t.string    :breed_group
      t.string    :color_group
      t.string    :weight_group
      t.string    :age_group
      t.timestamp :intake_date
      t.timestamp :outcome_date
      t.integer   :length_of_stay
      t.string    :intake_type, :null => false
      t.string    :outcome_type, :null => false
      t.timestamps null: false
    end

    add_index :length_of_stays, :outcome_id, unique: true
    add_index :length_of_stays, [:animal_id, :outcome_date, :intake_date, :group_id], :name => 'length_of_stays_uidx', unique: true
    add_index :length_of_stays, :group_id
    add_index :length_of_stays, :animal_type
    add_index :length_of_stays, :intake_type
    add_index :length_of_stays, :outcome_type
    add_index :length_of_stays, :gender
    add_index :length_of_stays, :breed_group
    add_index :length_of_stays, :color_group
    add_index :length_of_stays, :weight_group
    add_index :length_of_stays, :age_group

    conn.execute("ALTER TABLE length_of_stays ADD CONSTRAINT length_of_stays_outcome_id_fk FOREIGN KEY (outcome_id) REFERENCES outcomes(id)")
    conn.execute("ALTER TABLE length_of_stays ADD CONSTRAINT length_of_stays_group_id_fk FOREIGN KEY (group_id) REFERENCES groups(id)")

    conn.execute("ALTER TABLE length_of_stays ALTER COLUMN intake_date SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE length_of_stays ALTER COLUMN outcome_date SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE length_of_stays ALTER COLUMN created_at SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE length_of_stays ALTER COLUMN updated_at SET DATA TYPE timestamp with time zone")

    conn.execute("INSERT INTO breed_groups (name, description, created_at, updated_at) VALUES ('Bully breeds', 'Breeds classified as pit bulls or bully breeds', now(), now())")
    conn.execute("INSERT INTO breed_groups (name, description, created_at, updated_at) VALUES ('Guard breeds', 'Breeds classified as guard-type dogs, e.g., German Shepherds, Rottweilers, etc.', now(), now())")
    conn.execute("INSERT INTO breed_groups (name, description, created_at, updated_at) VALUES ('Small breeds', 'Breeds under 25 pounds', now(), now())")
    conn.execute("INSERT INTO breed_groups (name, description, created_at, updated_at) VALUES ('Sighthounds', 'Breeds that hunt by sight, e.g., greyhounds', now(), now())")
    conn.execute("INSERT INTO breed_groups (name, description, created_at, updated_at) VALUES ('Terriers', 'Terrier breeds', now(), now())")
    conn.execute("INSERT INTO breed_groups (name, description, created_at, updated_at) VALUES ('Retrievers', 'Retriever-type dogs, e.g., Labrador Retrievers, Golden Retrievers, Irish Setters, etc.', now(), now())")

    conn.execute("INSERT INTO age_groups (name, description, created_at, updated_at) VALUES ('5 Months and Under', 'Animals under 5 months of age', now(), now())")
    conn.execute("INSERT INTO age_groups (name, description, created_at, updated_at) VALUES ('5 Months to 1 year', 'Adolescent animals between 5 months and 1 year', now(), now())")
    conn.execute("INSERT INTO age_groups (name, description, created_at, updated_at) VALUES ('1-2 years', 'Animals between 1 and 2 years old', now(), now())")
    conn.execute("INSERT INTO age_groups (name, description, created_at, updated_at) VALUES ('2-7 years', 'Mature animals from 2 years to 7 years old', now(), now())")
    conn.execute("INSERT INTO age_groups (name, description, created_at, updated_at) VALUES ('7-10 years', 'Older animals from 7 years to 10 years old', now(), now())")
    conn.execute("INSERT INTO age_groups (name, description, created_at, updated_at) VALUES ('10 years and over', 'Senior animals over 10 years old', now(), now())")

    conn.execute("INSERT INTO weight_groups (name, description, created_at, updated_at) VALUES ('Under 15 pounds', 'Animals under 15 pounds', now(), now())")
    conn.execute("INSERT INTO weight_groups (name, description, created_at, updated_at) VALUES ('15-30 pounds', 'Animals between 15 and 30 pounds', now(), now())")
    conn.execute("INSERT INTO weight_groups (name, description, created_at, updated_at) VALUES ('30-50 pounds', 'Animals between 30 and 50 pounds', now(), now())")
    conn.execute("INSERT INTO weight_groups (name, description, created_at, updated_at) VALUES ('50-80 pounds', 'Animals between 50 and 80 pounds', now(), now())")
    conn.execute("INSERT INTO weight_groups (name, description, created_at, updated_at) VALUES ('80+ pounds', 'Animals 80 pounds or more', now(), now())")

    conn.execute("INSERT INTO color_groups (name, description, created_at, updated_at) VALUES ('Black', 'Animals of predominately black coloring', now(), now())")
    conn.execute("INSERT INTO color_groups (name, description, created_at, updated_at) VALUES ('White', 'Animals of predominately white coloring', now(), now())")
    conn.execute("INSERT INTO color_groups (name, description, created_at, updated_at) VALUES ('Yellow or Tan', 'Animals of predominately yellow or tan coloring', now(), now())")
    conn.execute("INSERT INTO color_groups (name, description, created_at, updated_at) VALUES ('Brown', 'Animals of predominately brown coloring', now(), now())")
    conn.execute("INSERT INTO color_groups (name, description, created_at, updated_at) VALUES ('Red', 'Animals of predominately red coloring', now(), now())")
  end

  def down
    drop_table :length_of_stays
    drop_table :breed_groups
    drop_table :color_groups
    drop_table :weight_groups
    drop_table :age_groups
  end

end
