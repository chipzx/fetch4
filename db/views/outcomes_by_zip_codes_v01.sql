SELECT o.group_id, 
       a.postal_code, 
       count(*) AS total_outcomes
FROM   outcomes o
JOIN   addresses a ON (o.address_id = a.id)
GROUP  BY o.group_id, a.postal_code
