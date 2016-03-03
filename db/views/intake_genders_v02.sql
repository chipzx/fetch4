SELECT at.name AS animal_type,
       g.description AS gender,
       it.name AS intake_type,
       i.group_id,
       i.fiscal_year,
       count(*) AS total
FROM   intakes i
JOIN   intake_types it ON (i.intake_type_id = it.id AND i.group_id = it.group_id)
JOIN   animal_types at ON (i.animal_type_id = at.id AND i.group_id = at.group_id)
JOIN   genders g ON (i.gender_id = g.id AND i.group_id = g.group_id)
GROUP  BY at.name, g.description, it.name, i.group_id, i.fiscal_year;
