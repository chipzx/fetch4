DROP FUNCTION IF EXISTS set_population(integer);
CREATE FUNCTION set_population(p_group_id integer) RETURNS VOID AS
$$
DECLARE
  v_today DATE;
  v_yesterday DATE;
  v_current_population INTEGER;
  v_intakes INTEGER;
  v_outcomes INTEGER;
  v_first_outcome DATE;
  v_first_intake DATE;
  v_start_date DATE;
  v_end_date DATE;
BEGIN
  DELETE FROM population_by_days WHERE group_id = p_group_id;

  SELECT now()::DATE INTO v_today;
  v_end_date := v_today;

  -- this is the total number of animals as of start of business today, i.e., COB yesterday
  SELECT count(*) INTO v_current_population FROM animals WHERE group_id = p_group_id;

  -- now get intakes and outcomes by day back to last day you have both and add delta of intakes - outcomes to population, working backwards

  SELECT MIN(intake_date::DATE) INTO v_first_intake FROM intakes WHERE group_id = p_group_id;
  SELECT MIN(outcome_date::DATE) INTO v_first_outcome FROM outcomes WHERE group_id = p_group_id;

  v_start_date := GREATEST(v_first_intake, v_first_outcome);
  LOOP
    v_end_date := v_end_date - '1 day'::interval;
    EXIT WHEN v_end_date < v_start_date;

    SELECT COUNT(*) INTO v_intakes FROM intakes WHERE group_id = p_group_id AND intake_date::DATE = v_end_date;
    SELECT COUNT(*) INTO v_outcomes FROM outcomes WHERE group_id = p_group_id AND outcome_date::DATE = v_end_date;
    RAISE NOTICE 'Intakes: % Outcomes: % Population % For %', v_intakes, v_outcomes, v_current_population, v_end_date;

    INSERT INTO population_by_days
      (calendar_date, group_id, total_intakes, total_outcomes, total_population,
       created_at, updated_at)
    VALUES
      (v_end_date, p_group_id, v_intakes, v_outcomes, v_current_population, now(), now());

    v_current_population := v_current_population - v_intakes + v_outcomes;

  END LOOP;
END;
$$
LANGUAGE plpgsql;
