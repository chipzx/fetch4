CREATE OR REPLACE FUNCTION calc_age(end_date TIMESTAMP WITH TIME ZONE, start_date TIMESTAMP WITH TIME ZONE) RETURNS interval AS
$$
BEGIN
  RETURN age(DATE_TRUNC('month', end_date), DATE_TRUNC('month', start_date));
END;
$$
LANGUAGE plpgsql;
