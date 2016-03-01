SELECT i.id,
       i.group_id,
       at.name as animal_type,
       it.name AS intake_type,
       s.name AS gender,
       i.weight,
       i.age,
       i.breed,
       i.coloring,
       i.address_id,
       i.fiscal_year,
       at.trackable_animal,
       it.trackable_intake,
       it.live_intake,
       i.latitude,
       i.longitude,
       i.geo_quality_code,
       i.postal_code,
       t.calendar_date,
       t.calendar_year,
       t.quarter,
       t.month,
       t.week,
       t.day_of_month,
       t.day_of_week,
       t.day_of_year,
       TO_NUMBER(TO_CHAR(intake_date AT TIME ZONE g.time_zone, 'HH24'), '99') AS intake_hour
FROM   intakes i
JOIN   groups g ON (i.group_id = g.id)
JOIN   animal_types at ON (i.animal_type_id = at.id)
JOIN   intake_types it ON (i.intake_type_id = it.id)
JOIN   genders s ON (i.gender_id = s.id)
JOIN   time_dimension t ON (i.intake_date::DATE AT TIME ZONE g.time_zone = t.calendar_date)

