CREATE OR REPLACE function lookup_intake_type_id(p_name VARCHAR, p_group_id INTEGER) RETURNS integer AS
$$
DECLARE
  v_intake_type_id INTEGER;
BEGIN
  SELECT id INTO v_intake_type_id FROM intake_types it WHERE it.name = p_name AND it.group_id = p_group_id;
  RETURN v_intake_type_id;
END;
$$
LANGUAGE plpgsql;
