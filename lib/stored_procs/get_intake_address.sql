CREATE OR REPLACE FUNCTION get_intake_address(p_location_found VARCHAR, p_jurisdiction VARCHAR) RETURNS varchar AS
$$
DECLARE
  v_address VARCHAR;
BEGIN
  v_address := TRIM(COALESCE(p_location_found, '')||' '||REPLACE(COALESCE(p_jurisdiction, ''), '(Not City) ', ''));
  return v_address;
END;
$$
LANGUAGE plpgsql;
