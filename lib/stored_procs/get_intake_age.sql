CREATE OR REPLACE FUNCTION get_intake_age(p_age_string VARCHAR) RETURNS INTERVAL AS
$$
DECLARE
  v_age INTERVAL;
  v_age_string VARCHAR;
BEGIN
  v_age_string := REPLACE(p_age_string, 'yr', ' yr');
  v_age_string := REPLACE(v_age_string, 'mos', ' mons');
  IF REGEXP_MATCHES(v_age_string, '^[0-9]') IS NOT NULL THEN
    BEGIN
      v_age := v_age_string::INTERVAL;
    EXCEPTION
      WHEN OTHERS THEN v_age:= NULL;
    END;
  END IF;
  return v_age;
END;
$$
LANGUAGE plpgsql;
