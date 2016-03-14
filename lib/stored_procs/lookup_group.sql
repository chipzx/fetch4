DROP FUNCTION lookup_group(VARCHAR);
CREATE OR REPLACE FUNCTION lookup_group(p_group_name VARCHAR) RETURNS groups AS
$$
DECLARE
  v_row_groups groups%ROWTYPE;
BEGIN
  SELECT * INTO v_row_groups FROM groups WHERE name = p_group_name;
  RETURN v_row_groups;
END;
$$
LANGUAGE plpgsql;

