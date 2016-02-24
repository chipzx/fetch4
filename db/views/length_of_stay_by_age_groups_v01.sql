SELECT   group_id, 
         animal_type, 
         outcome_type, 
         age_group, 
         a.id AS sort_order,
         SUM(length_of_stay) AS total_length,
         COUNT(*) AS total_animals,
         ROUND((SUM(length_of_stay)*1.0)/(COUNT(*)*1.0),2) AS avg_length_of_stay
FROM     length_of_stays l
JOIN     age_groups a ON (a.name = l.age_group)
WHERE    age_group IS NOT NULL
GROUP BY group_id, animal_type, outcome_type, age_group, a.id;
