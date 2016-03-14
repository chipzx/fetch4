CREATE OR REPLACE FUNCTION get_fiscal_year(date_str VARCHAR, date_format VARCHAR, fy_start_quarter INTEGER) RETURNS integer AS
$$
DECLARE
  v_date TIMESTAMP;
  v_year INTEGER;
  v_fy_offset_months INTEGER;  
  v_fy_offset_interval INTERVAL;  
BEGIN
  BEGIN
    v_date := TO_TIMESTAMP(date_str, date_format);
    IF (fy_start_quarter > 1) THEN
      v_fy_offset_months := (5 - fy_start_quarter) * 3;
      v_fy_offset_interval := (v_fy_offset_months||' months')::INTERVAL;
      v_date := v_date + v_fy_offset_interval;
    END IF;
    v_year := EXTRACT(YEAR FROM v_date);
--  EXCEPTION
--    WHEN OTHERS THEN
--      v_year := NULL;
  END;
  return v_year;
END;
$$
LANGUAGE plpgsql;
