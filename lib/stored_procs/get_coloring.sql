DROP FUNCTION get_coloring(VARCHAR, VARCHAR, VARCHAR, VARCHAR, VARCHAR);
CREATE OR REPLACE function get_coloring(p_primary_color VARCHAR, p_secondary_color VARCHAR, p_third_color VARCHAR, p_color_pattern VARCHAR, p_second_color_pattern VARCHAR) RETURNS varchar AS
$$
DECLARE
  v_coloring VARCHAR;
BEGIN
  v_coloring := TRIM(COALESCE(p_primary_color,''));
  v_coloring := v_coloring||' '||TRIM(COALESCE(p_secondary_color,''));
  v_coloring := v_coloring||' '||TRIM(COALESCE(p_third_color,''));
  v_coloring := v_coloring||' '||TRIM(COALESCE(p_color_pattern,''));
  v_coloring := v_coloring||' '||TRIM(COALESCE(p_second_color_pattern,''));
  return v_coloring;
END;
$$
LANGUAGE plpgsql;
