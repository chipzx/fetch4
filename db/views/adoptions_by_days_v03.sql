SELECT   y.fiscal_year, 
         TO_CHAR(outcome_date AT TIME ZONE g.time_zone, 'D') AS day_index, 
         CASE (TO_NUMBER(TO_CHAR(outcome_date AT TIME ZONE g.time_zone, 'D'), '9') - 1) 
           WHEN 0 THEN 7 
           ELSE TO_NUMBER(TO_CHAR(outcome_date AT TIME ZONE g.time_zone, 'D'), '9') - 1
         END::integer AS sort_order,
         TO_CHAR(outcome_date AT TIME ZONE g.time_zone, 'DY') AS day_of_week, 
         y.total_days AS total_days,
         y.group_id, 
         count(*) AS number_adoptions,
         ROUND((count(*)*1.0)/(total_days*1.0),2) as avg_daily_adoptions
FROM     outcomes o
JOIN     groups g ON (o.group_id = g.id)
JOIN     day_count_during_years y ON (TO_CHAR(o.outcome_date AT TIME ZONE g.time_zone, 'DY') = y.day_of_week AND o.fiscal_year = y.fiscal_year and o.group_id = y.group_id)
WHERE    outcome_type_id = (SELECT id FROM outcome_types ot WHERE ot.group_id = o.group_id AND ot.name = 'Adoption')
GROUP BY y.fiscal_year, 
         y.group_id, 
         y.total_days,
         TO_CHAR(outcome_date AT TIME ZONE g.time_zone, 'DY'), 
         CASE (TO_NUMBER(TO_CHAR(outcome_date AT TIME ZONE g.time_zone, 'D'), '9') - 1) 
           WHEN 0 THEN 7 
           ELSE TO_NUMBER(TO_CHAR(outcome_date AT TIME ZONE g.time_zone, 'D'), '9') - 1
         END,
         TO_CHAR(outcome_date AT TIME ZONE g.time_zone, 'D');
