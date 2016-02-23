SELECT o.group_id, 
       TO_NUMBER(TO_CHAR(outcome_date AT TIME ZONE g.time_zone, 'HH24'), '99') AS hour, 
       ot.name AS outcome_type, 
       count(*) AS total
FROM   outcomes o
JOIN   outcome_types ot ON (o.outcome_type_id = ot.id AND 
                            o.group_id = ot.group_id)
JOIN   groups g ON (o.group_id = g.id)
GROUP BY o.group_id, 
         TO_NUMBER(TO_CHAR(outcome_date AT TIME ZONE g.time_zone, 'HH24'),'99'),
         ot.name;
