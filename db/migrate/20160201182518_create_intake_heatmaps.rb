class CreateIntakeHeatmaps < ActiveRecord::Migration
  def up
    conn = ActiveRecord::Base.connection
    conn.execute("CREATE VIEW intake_heatmaps AS
SELECT   found_location, latitude, longitude, count(*) AS total 
FROM     intakes
WHERE    latitude != 0.0 AND valid_address 
GROUP BY found_location, latitude, longitude")
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
                   WHERE    (intakes_1.valid_address)
                   GROUP BY intakes_1.found_location, 
                            intakes_1.latitude, 
                            intakes_1.longitude, 
                            intakes_1.group_id
                   HAVING   (count(*) >= 20)
                  ) hs
          )
        )
GROUP BY intakes.found_location, 
         intakes.latitude, 
         intakes.longitude, 
         at.name, 
         g.name,  
         it.name, 
         intakes.fiscal_year, 
         intakes.group_id;")
  end

  def down
    conn = ActiveRecord::Base.connection
    conn.execute("DROP VIEW intake_heatmaps")
    conn.execute("DROP VIEW hotspots")
  end
end
