CREATE OR REPLACE FUNCTION color_group(color VARCHAR) RETURNS VARCHAR AS
$$
DECLARE
  the_color_group VARCHAR;
BEGIN
  SELECT color_group INTO the_color_group FROM color_group_mappings WHERE LOWER(color) LIKE coloring ORDER BY precedence LIMIT 1;
  IF the_color_group IS NULL THEN
    the_color_group := 'Other';
  END IF;
  RETURN the_color_group;
END;
$$
LANGUAGE plpgsql;
