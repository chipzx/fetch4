SELECT r.name AS service_request_type,
       s.name AS service_request_status_type,
       c.group_id,
       a.full_location,
       a.latitude,
       a.longitude,
       a.postal_code,
       c.fiscal_year,
       count(*) AS total
FROM   animal_services311_calls c
JOIN   addresses a ON (c.address_id = a.id)
JOIN   service_request_types r ON (c.service_request_type_id = r.id AND c.group_id = r.group_id)
JOIN   service_request_status_types s ON (c.service_request_status_type_id = s.id AND c.group_id = s.group_id)
WHERE  a.valid_address
GROUP  BY r.name, s.name, c.group_id, a.full_location, a.latitude, a.longitude, a.postal_code, c.fiscal_year
