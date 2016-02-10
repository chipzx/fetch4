SELECT   fiscal_year, 
         group_id, 
         to_char(outcome_date, 'DY') AS day_of_week, 
         count(*) total_days
FROM     (SELECT DISTINCT fiscal_year, 
                          group_id, 
                          outcome_date 
          FROM   outcomes) ad 
GROUP BY fiscal_year, 
         group_id, 
         to_char(outcome_date, 'DY');
