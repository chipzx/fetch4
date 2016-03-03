SELECT at.name AS animal_type,
       ot.name AS outcome_type,
       g.description AS gender,
       o.group_id,
       o.fiscal_year,
       count(*) AS total
FROM   outcomes o
JOIN   animal_types at ON (o.animal_type_id = at.id AND o.group_id = at.group_id)
JOIN   outcome_types ot ON (o.outcome_type_id = ot.id AND o.group_id = ot.group_id)
JOIN   genders g ON (o.gender_id = g.id AND o.group_id = g.group_id)
GROUP  BY at.name, ot.name, g.description, o.group_id, o.fiscal_year
