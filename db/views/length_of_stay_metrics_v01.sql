SELECT o.id AS outcome_id,
       o.animal_id,
       o.group_id,
       o.animal_type,
       o.gender,
       o.intake_type,
       o.intake_date,
       o.outcome_type,
       o.outcome_date,
       o.outcome_date::DATE - o.intake_date::DATE AS length_of_stay,
       o.age,
       age_group(o.age) AS age_group,
       breed_group(o.breed) AS breed_group,
       color_group(o.coloring) AS color_group,
       o.fiscal_year,
       o.calendar_year,
       o.month,
       o.week,
       o.quarter,
       o.day_of_month,
       o.day_of_week,
       o.day_of_year,
       a.from_in_months
FROM   outcome_metrics o
JOIN   age_groups a ON (age_group(o.age) = a.name)
WHERE  o.intake_date is not null
  AND  o.outcome_date IS NOT NULL;

