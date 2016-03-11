CREATE OR REPLACE FUNCTION breed_group(breed_name varchar) RETURNS VARCHAR AS
$$
DECLARE
  the_breed_group VARCHAR;
  species VARCHAR;
BEGIN
  SELECT breed_group, animal_type INTO the_breed_group, species FROM breed_group_mappings WHERE LOWER(breed_name) LIKE breed;
  IF the_breed_group IS NULL THEN
    the_breed_group := 'Other';
  END IF;
  return the_breed_group;
END;
$$
LANGUAGE plpgsql;
