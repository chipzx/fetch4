DROP FUNCTION lookup_animal_type_id(VARCHAR, INTEGER);
CREATE OR REPLACE FUNCTION lookup_animal_type_id(p_name VARCHAR, p_group_id INTEGER) RETURNS integer AS
$$
DECLARE
  v_animal_type_id integer;
BEGIN
  SELECT id INTO v_animal_type_id FROM animal_types a WHERE a.name = p_name AND a.group_id = p_group_id;
  RETURN v_animal_type_id;
END;
$$
LANGUAGE plpgsql;
