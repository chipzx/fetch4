SELECT c.id,
       c.service_request_id,
       c.group_id,
       c.service_request_type_id,
       sr.name AS service_request_type,
       c.owning_department,
       c.method_received,
       c.service_request_status_type_id,
       st.name AS service_request_status_type,
       c.status_change_date,
       c.date_opened,
       c.last_updated,
       c.date_closed,
       c.service_request_location,
       c.address_id,
       a.latitude,
       a.longitude,
       a.postal_code,
       a.geo_quality_code,
       a.feature_type,
       a.valid_address,
       c.jurisdiction,
       c.jurisdiction_name,
       c.fiscal_year,
       t.calendar_year,
       t.month,
       t.day_of_month,
       t.day_of_week,
       t.day_of_year,
       t.week,
       t.quarter
FROM   animal_services311_calls c
JOIN   groups g ON (c.group_id = g.id)
JOIN   service_request_types sr ON (c.service_request_type_id = sr.id AND
                                    c.group_id = sr.group_id)
JOIN   service_request_status_types st ON 
       (c.service_request_status_type_id = st.id AND c.group_id = st.group_id)
LEFT OUTER JOIN   addresses a ON (c.address_id = a.id)
JOIN   time_dimension t ON (c.date_opened::DATE = t.calendar_date)

