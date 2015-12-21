class FixMissingFks < ActiveRecord::Migration
  def up
    conn = ActiveRecord::Base.connection
    conn.execute("ALTER TABLE animal_types ADD CONSTRAINT animal_types_groups_fk FOREIGN KEY (group_id) REFERENCES groups(id)")
    conn.execute("ALTER TABLE intake_types ADD CONSTRAINT intake_types_groups_fk FOREIGN KEY (group_id) REFERENCES groups(id)")
  end

  def down
    conn = ActiveRecord::Base.connection
    conn.execute("ALTER TABLE animal_types DROP CONSTRAINT animal_types_groups_fk")
    conn.execute("ALTER TABLE intake_types DROP CONSTRAINT intake_types_groups_fk")
  end
end
