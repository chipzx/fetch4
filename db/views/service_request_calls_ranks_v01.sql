SELECT t.service_request_type_id, t.service_request_type, t.group_id, totals, row_number() OVER () AS rank
FROM   (SELECT a.service_request_type_id, sr.name AS service_request_type, a.group_id, count(*) AS totals
        FROM   animal_services311_calls a
        JOIN   service_request_types sr 
               ON (a.service_request_type_id = sr.id AND 
                   a.group_id = sr.group_id)
        GROUP BY a.service_request_type_id, sr.name, a.group_id
        ORDER BY totals DESC) t;
