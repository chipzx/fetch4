SELECT animal_type, 
       outcome_type,
       group_id,
       SUM(length_of_stay) as total_length,
       COUNT(*) AS total_animals,
       ROUND((SUM(length_of_stay)*1.0)/(COUNT(*)*1.0), 2) AS avg_length_of_stay
FROM   length_of_stays
WHERE  length_of_stay IS NOT NULL
GROUP  BY animal_type, outcome_type, group_id;
