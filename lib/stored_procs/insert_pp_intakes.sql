CREATE OR REPLACE FUNCTION insert_pp_intakes(p_group_name VARCHAR) RETURNS VOID AS
$$
DECLARE
  v_intake_date_format VARCHAR := 'MM/DD/YYYY HH:MI PM';

  v_group groups%ROWTYPE;
  v_group_id groups.id%TYPE;
  v_group_tz groups.time_zone%TYPE;
  v_group_fy_quarter groups.fiscal_year_start_quarter%TYPE;

  v_animal_type_id animal_types.id%TYPE;
  v_intake_type_id intake_types.id%TYPE;
  v_gender_id genders.id%TYPE;

  v_rec_exists boolean := false;

  v_intake_rec pp_extended_intakes%ROWTYPE;
  cur_intake CURSOR FOR SELECT * FROM pp_extended_intakes;
 
  v_total_recs INTEGER := 0;
  v_recs_inserted INTEGER := 0;

BEGIN
  v_group := lookup_group(p_group_name);
  IF v_group IS NULL THEN
    RAISE EXCEPTION '% is not a valid group name', p_group_name;
  ELSE
    v_group_id := v_group.id;
    v_group_tz := v_group.time_zone;
    v_group_fy_quarter := v_group.fiscal_year_start_quarter;

    PERFORM set_config('timezone', v_group_tz, true);
    
    FOR v_intake_rec IN cur_intake LOOP
      v_animal_type_id := lookup_animal_type_id(v_intake_rec.animal_type, v_group_id);
      v_intake_type_id := lookup_intake_type_id(v_intake_rec.operation_type, v_group_id);
      v_gender_id := lookup_gender_id(v_intake_rec.gender, v_group_id);

      SELECT true INTO v_rec_exists 
      FROM   intakes i 
      WHERE  i.animal_id = v_intake_rec.animal_id
        AND  i.intake_type_id = v_intake_type_id 
        AND  i.group_id = v_group_id
        AND  i.intake_date = TO_TIMESTAMP(v_intake_rec.intake_date_time, v_intake_date_format);

      v_total_recs := v_total_recs + 1;

      IF v_rec_exists IS NULL THEN
        INSERT INTO intakes
          (animal_type_id, group_id, animal_id, name, intake_date, intake_type_id, found_location, gender_id, breed, coloring, age,
           fiscal_year, created_at, updated_at)
        VALUES
          (v_animal_type_id,
           v_group_id,
           v_intake_rec.animal_id,
           v_intake_rec.animal_name,
           TO_TIMESTAMP(v_intake_rec.intake_date_time, v_intake_date_format),
           v_intake_type_id,
           get_intake_address(v_intake_rec.location_found, v_intake_rec.jurisdiction),
           v_gender_id,
           TRIM(v_intake_rec.primary_breed||' '|| COALESCE(v_intake_rec.secondary_breed, '')),
           get_coloring(v_intake_rec.primary_color, v_intake_rec.secondary_color, v_intake_rec.third_color, v_intake_rec.color_pattern,
                        v_intake_rec.second_color_pattern), 
           get_intake_age(v_intake_rec.age),
           get_fiscal_year(v_intake_rec.intake_date_time, v_intake_date_format, v_group_fy_quarter),
           now(),
           now()
          );
          v_recs_inserted := v_recs_inserted + 1;
      ELSE
        RAISE NOTICE 'Found record in intakes with animal id % intake date %', v_intake_rec.animal_id, v_intake_rec.intake_date_time;
      END IF;
    END LOOP; 
    RAISE NOTICE 'Inserted % records into Intakes out of a total of % input records', v_recs_inserted, v_total_recs;
  END IF;
END;
$$
LANGUAGE plpgsql;
