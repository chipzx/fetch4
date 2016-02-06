class CreateIntakeHeatmaps < ActiveRecord::Migration
  def up

    add_column :groups, :fiscal_year_start, :string, :null => false, :default => 'January 1'
    add_column :groups, :fiscal_year_start, :string, :null => false, :default => 'December 31'
    add_column :outcomes, :fiscal_year, :integer

    conn = ActiveRecord::Base.connection
    conn.execute("ALTER TABLE intakes ALTER COLUMN fiscal_year SET DATA TYPE integer USING fiscal_year::integer")
    conn.execute("CREATE VIEW intake_heatmaps AS
SELECT   i.group_id, 
         found_location, 
         latitude, 
         longitude, 
         at.name as animal_type,
         it.name as intake_type,
         g.description as gender,
         fiscal_year,
         count(*) AS total 
FROM     intakes i
JOIN     intake_types it ON (it.id = i.intake_type_id)
JOIN     animal_types at ON (at.id = i.animal_type_id)
JOIN     genders g ON (g.id = i.gender_id)
WHERE    latitude is NOT NULL AND latitude != 0.0 AND valid_address 
GROUP BY i.group_id, found_location, latitude, longitude, at.name, it.name, g.description, fiscal_year")

    conn.execute("CREATE VIEW hotspots AS
SELECT intakes.found_location,
       intakes.latitude,
       intakes.longitude,
       at.name AS animal_type,
       g.name AS gender,
       it.name AS intake_type,
       intakes.group_id,
       intakes.fiscal_year,
       count(*) AS total
FROM   intakes
JOIN   intake_types it ON (it.id = intakes.intake_type_id)
JOIN   animal_types at ON (at.id = intakes.animal_type_id)
JOIN   genders g ON (g.id = intakes.gender_id)
WHERE  ((intakes.found_location)::text IN 
         ( 
          SELECT hs.found_location
          FROM   ( SELECT   intakes_1.found_location,
                            intakes_1.latitude,
                            intakes_1.longitude,
                            intakes_1.group_id,
                            count(*) AS count
                   FROM     intakes intakes_1
                   WHERE    intakes_1.valid_address
                     AND    latitude IS NOT NULL
                   GROUP BY intakes_1.found_location, 
                            intakes_1.latitude, 
                            intakes_1.longitude, 
                            intakes_1.group_id
                   HAVING   (count(*) >= 20)
                  ) hs
          )
        )
  AND  latitude is NOT NULL
GROUP  BY intakes.found_location, 
          intakes.latitude, 
          intakes.longitude, 
          at.name, 
          g.name,  
          it.name, 
          intakes.fiscal_year, 
          intakes.group_id;")

    conn.execute("CREATE VIEW hotspot_details AS
SELECT   found_location, latitude, longitude, animal_type, fiscal_year, group_id, sum(total) AS total
FROM     hotspots
GROUP BY found_location, latitude, longitude, animal_type, fiscal_year, group_id
ORDER BY group_id, found_location, latitude, longitude, animal_type, fiscal_year")
  end

  def down
    conn = ActiveRecord::Base.connection
    conn.execute("DROP VIEW intake_heatmaps")
    conn.execute("DROP VIEW hotspot_details")
    conn.execute("DROP VIEW hotspots")
    conn.execute("ALTER TABLE intakes ALTER COLUMN fiscal_year SET DATA TYPE varchar")
  end
end
