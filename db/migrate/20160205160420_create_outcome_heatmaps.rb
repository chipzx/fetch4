class CreateOutcomeHeatmaps < ActiveRecord::Migration
  def up
    conn = ActiveRecord::Base.connection
    conn.execute("DROP VIEW IF EXISTS outcome_heatmaps")
    conn.execute("CREATE VIEW outcome_heatmaps AS
SELECT   o.group_id, 
         a.full_location AS found_location, 
         a.latitude, 
         a.longitude, 
         at.name as animal_type,
         ot.name as outcome_type,
         g.description as gender,
         o.fiscal_year,
         count(*) AS total 
FROM     outcomes o
JOIN     addresses a ON (o.address_id = a.id)
JOIN     outcome_types ot ON (ot.id = o.outcome_type_id)
JOIN     animal_types at ON (at.id = o.animal_type_id)
JOIN     genders g ON (g.id = o.gender_id)
WHERE    a.latitude is NOT NULL AND a.latitude != 0.0 AND valid_address 
GROUP BY o.group_id, a.full_location, a.latitude, a.longitude, at.name, ot.name, g.description, o.fiscal_year")
  end
  def down
    conn = ActiveRecord::Base.connection
    conn.execute("DROP VIEW IF EXISTS outcome_heatmaps")
  end
end
