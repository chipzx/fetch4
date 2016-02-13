SELECT m.service_request_type, 
       s.found_location, 
       s.latitude, 
       s.longitude, 
       s.group_id,
       s.fiscal_year, 
       count(*) AS total
FROM   animal_services311_hotspots s
JOIN   animal_services311_heatmaps m ON (s.found_location = m.full_location AND
                                         s.latitude = m.latitude AND 
                                         s.longitude = m.longitude AND
                                         s.group_id = m.group_id AND
                                         s.fiscal_year = m.fiscal_year)
GROUP  BY m.service_request_type, s.found_location, s.latitude, s.longitude, s.group_id, s.fiscal_year

