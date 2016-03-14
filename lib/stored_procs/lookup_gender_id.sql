CREATE OR REPLACE FUNCTION lookup_gender_id(p_name VARCHAR, p_spayed_or_neutered VARCHAR, p_group_id INTEGER) RETURNS integer AS
$$
DECLARE
  v_gender_id integer;
BEGIN
  IF p_name = 'M' THEN
    IF (p_spayed_or_neutered = 'Y') THEN
      p_name := 'N';
    END IF;
  END IF;
  IF p_name = 'F' THEN
    IF (p_spayed_or_neutered = 'Y') THEN
      p_name := 'S';
    END IF;
  END IF;
  SELECT id INTO v_gender_id FROM genders g WHERE g.group_id = p_group_id AND (g.name = p_name OR g.description = p_name);
  RETURN v_gender_id;
END;
$$
LANGUAGE plpgsql;
