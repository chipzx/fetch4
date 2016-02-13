SELECT full_location AS found_location, latitude, longitude, group_id, fiscal_year, count(*) as total
FROM   animal_services311_heatmaps
GROUP  BY full_location, latitude, longitude, group_id, fiscal_year
HAVING count(*) >= 15
