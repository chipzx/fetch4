CREATE OR REPLACE function age_group(age interval) RETURNS varchar AS
$$
DECLARE
  num_months integer;
  the_age_group varchar;
BEGIN
  num_months = 12*(EXTRACT('years' FROM AGE)) + EXTRACT('months' FROM AGE);
  SELECT name INTO the_age_group FROM age_groups WHERE num_months >= from_in_months AND num_months < to_in_months;
  return the_age_group;
END;
$$
LANGUAGE plpgsql;
