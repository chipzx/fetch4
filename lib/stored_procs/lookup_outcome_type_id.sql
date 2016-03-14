CREATE OR REPLACE FUNCTION lookup_outcome_type_id(p_outcome_type VARCHAR, p_group_id INTEGER) RETURNS integer AS
$$
DECLARE
  v_outcome_type_id outcome_types.id%TYPE;
BEGIN
  SELECT id INTO v_outcome_type_id FROM outcome_types ot WHERE ot.name = p_outcome_type AND ot.group_id = p_group_id;
  return v_outcome_type_id;
END;
$$
LANGUAGE plpgsql;
