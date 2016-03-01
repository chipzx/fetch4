SELECT o.id,
       o.group_id, 
       o.animal_type_id,
       o.animal_id,
       o.name, 
       at.name AS animal_type,
       at.trackable_animal,
       o.outcome_type_id,
       ot.name AS outcome_type,
       o.outcome_date,
       o.intake_type_id,
       ot.trackable_outcome,
       ot.live_outcome,
       it.name AS intake_type,
       o.intake_date,
       it.trackable_intake,
       o.gender_id,
       g.description AS gender,
       o.breed,
       o.coloring,
       o.weight,
       o.age,
       o.fiscal_year,
       t.calendar_year,
       t.month,
       t.day_of_month,
       t.day_of_week,
       t.day_of_year,
       t.week,
       t.quarter,
       EXTRACT(HOUR FROM outcome_date AT TIME ZONE g.time_zone) AS outcome_hour,
       o.address_id,
       a.postal_code,
       a.latitude,
       a.longitude,
       a.geo_quality_code,
       a.feature_type,
       a.full_location,
       a.valid_address
FROM   outcomes o
JOIN   groups g ON (o.group_id = g.id)
JOIN   animal_types at ON (o.animal_type_id = at.id)
JOIN   outcome_types ot ON (o.outcome_type_id = ot.id)
LEFT OUTER JOIN intake_types it ON (o.intake_type_id = it.id)
JOIN   genders s ON (o.gender_id = s.id)
LEFT OUTER JOIN addresses a ON (o.address_id = a.id)
JOIN   time_dimension t ON (o.outcome_date::DATE AT TIME ZONE g.time_zone = t.calendar_date);
