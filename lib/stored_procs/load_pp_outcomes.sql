DROP FUNCTION load_pp_outcomes(VARCHAR);
CREATE OR REPLACE FUNCTION load_pp_outcomes(p_group_name VARCHAR) RETURNS VOID AS
$$
DECLARE
  v_timestamp_format VARCHAR := 'MM/DD/YYYY HH:MI PM';

  v_group groups%ROWTYPE;
  v_group_id groups.id%TYPE;
  v_group_tz groups.time_zone%TYPE;
  v_group_fy_quarter groups.fiscal_year_start_quarter%TYPE;

  v_animal_type_id animal_types.id%TYPE;
  v_outcome_type_id outcome_types.id%TYPE;
  v_gender_id genders.id%TYPE;

  v_outcome_rec pp_extended_outcomes%ROWTYPE;

  v_rec_exists boolean := false;

  cur_outcomes CURSOR FOR SELECT * FROM pp_extended_outcomes;
 
  v_total_records INTEGER := 0;
  v_new_outcomes INTEGER := 0;
BEGIN
  v_group := lookup_group(p_group_name);
  IF v_group IS NULL THEN
    RAISE EXCEPTION '% is not a valid group name', p_group_name;
  ELSE
    v_group_id := v_group.id;
    v_group_tz := v_group.time_zone;
    v_group_fy_quarter := v_group.fiscal_year_start_quarter;

    PERFORM set_config('timezone', v_group_tz, true);

    FOR v_outcome_rec IN cur_outcomes LOOP
      v_animal_type_id := lookup_animal_type_id(v_outcome_rec.animal_type, v_group_id);
      v_outcome_type_id := lookup_outcome_type_id(v_outcome_rec.operation_type, v_group_id);
      v_gender_id := lookup_gender_id(v_outcome_rec.gender, v_outcome_rec.spayed_or_neutered, v_group_id);

      SELECT true INTO v_rec_exists
      FROM   outcomes o
      WHERE  o.animal_id = v_outcome_rec.animal_id
        AND  o.group_id = v_group_id
        AND  o.outcome_type_id  = v_outcome_type_id
        AND  o.outcome_date = TO_TIMESTAMP(v_outcome_rec.outcome_date_time, v_timestamp_format);

      v_total_records := v_total_records + 1;
      IF v_rec_exists IS NULL THEN
        INSERT INTO outcomes
          (animal_type_id, animal_id, group_id, name, outcome_type_id, outcome_date, gender_id, address_id, breed, coloring, dob,
           age, fiscal_year, created_at, updated_at)
        VALUES
          (v_animal_type_id,
           v_outcome_rec.animal_id,
           v_group_id,
           v_outcome_rec.name,
           v_outcome_type_id,
           TO_TIMESTAMP(v_outcome_rec.outcome_date_time, v_timestamp_format),
           v_gender_id,
           v_outcome_rec.address_id,
           TRIM(v_outcome_rec.primary_breed||' '|| COALESCE(v_outcome_rec.secondary_breed, '')),     
           TRIM(COALESCE(v_outcome_rec.primary_color, '')||' '||COALESCE(v_outcome_rec.secondary_color,'')),
           TO_TIMESTAMP(v_outcome_rec.dob, v_timestamp_format),
           age(TO_TIMESTAMP(v_outcome_rec.outcome_date_time, v_timestamp_format)::DATE,
               TO_TIMESTAMP(v_outcome_rec.dob, v_timestamp_format)::DATE),
           get_fiscal_year(v_outcome_rec.outcome_date_time, v_timestamp_format, v_group_fy_quarter),
           now(),
           now()
          );
          v_new_outcomes := v_new_outcomes + 1;
      ELSE
        RAISE NOTICE 'A record for animal_id % outcome type % outcome date % already exists';
      END IF;
    END LOOP;
    RAISE NOTICE 'Inserted % new outcome records out of % input records', v_new_outcomes, v_total_records;
  END IF;
END;
$$
LANGUAGE plpgsql;
