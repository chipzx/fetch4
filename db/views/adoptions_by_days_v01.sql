SELECT   y.fiscal_year, 
         TO_CHAR(outcome_date, 'D') AS day_index, 
         TO_CHAR(outcome_date, 'DY') AS day_of_week, 
         y.total_days AS total_days,
         y.group_id, 
         count(*) AS number_adoptions,
         ROUND((count(*)*1.0)/(total_days*1.0),2) as avg_daily_adoptions
FROM     outcomes o
JOIN     day_count_during_years y ON (TO_CHAR(o.outcome_date, 'DY') = y.day_of_week AND o.fiscal_year = y.fiscal_year and o.group_id = y.group_id)
WHERE    outcome_type_id = (SELECT id FROM outcome_types ot WHERE ot.group_id = o.group_id AND ot.name = 'Adoption')
GROUP BY y.fiscal_year, 
         y.group_id, 
         y.total_days,
         TO_CHAR(outcome_date, 'DY'), 
         TO_CHAR(outcome_date, 'D');
