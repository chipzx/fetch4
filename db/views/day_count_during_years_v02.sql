SELECT   fiscal_year, 
         group_id, 
         to_char(outcome_date, 'DY') as day_of_week, 
         count(*) total_days
FROM     (SELECT DISTINCT o.fiscal_year, 
                          o.group_id, 
			  DATE_TRUNC('Day', o.outcome_date AT TIME ZONE g.time_zone) AS outcome_date
          FROM   outcomes o
          JOIN   groups g ON (o.group_id = g.id)) ad 
GROUP BY fiscal_year, 
         group_id, 
         to_char(outcome_date, 'DY');
