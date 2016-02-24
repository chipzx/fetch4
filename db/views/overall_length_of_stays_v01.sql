SELECT animal_type, 
       outcome_type,
       group_id,
       ROUND(SUM(length_of_stay)*1.0/COUNT(*)*1.0, 2) AS avg_length_of_stay
FROM   length_of_stays
GROUP  BY animal_type, outcome_type, group_id;
