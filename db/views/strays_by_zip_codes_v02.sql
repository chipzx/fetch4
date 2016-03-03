SELECT i.group_id, postal_code, it.name as intake_type, count(*) as total
FROM   intakes i 
JOIN   intake_types it ON (i.intake_type_id = it.id AND i.group_id = it.group_id)
GROUP  BY i.group_id, postal_code, it.name;
