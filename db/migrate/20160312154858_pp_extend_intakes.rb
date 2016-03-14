class PpExtendIntakes < ActiveRecord::Migration
  def up
    conn = ActiveRecord::Base.connection
    create_table :pp_extended_intakes do |t|
      t.string :animal_id
      t.string :arn
      t.string :animal_name
      t.string :animal_type
      t.string :primary_breed
      t.string :secondary_breed
      t.string :gender
      t.string :age
      t.string :altered
      t.string :danger
      t.string :danger_reason
      t.string :primary_color
      t.string :secondary_color
      t.string :third_color
      t.string :color_pattern
      t.string :second_color_pattern
      t.string :size
      t.string :pre_altered
      t.string :spayed_neutered
      t.string :by
      t.string :record_owner
      t.string :intake_date_time
      t.string :operation_type
      t.string :operation_sub_type
      t.string :pet_id
      t.string :pet_id_type
      t.string :location_found
      t.string :jurisdiction
      t.string :condition
      t.string :age_group
      t.string :doa
      t.string :site_name
      t.string :source
      t.string :intake_reason
      t.string :length_owned
      t.string :unit
      t.string :injury_type
      t.string :cause
      t.string :agency_name
      t.string :location
      t.string :sub_location
      t.string :asilomar_status
    end
    conn.execute("ALTER TABLE pp_extended_intakes DROP COLUMN id")
  end
  def down
    drop_table :pp_extended_intakes
  end
end
