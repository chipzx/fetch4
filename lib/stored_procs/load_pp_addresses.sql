CREATE OR REPLACE FUNCTION load_pp_addresses(p_group_name VARCHAR) RETURNS void AS
$$
DECLARE
  v_party_type_id INTEGER := 1;
  v_group_id INTEGER;
  v_party_id INTEGER;
  v_address_id INTEGER;
  v_addr_type_id INTEGER := 1;
  person_cur CURSOR FOR SELECT * FROM pp_person_by_operation;
  rec_person RECORD;
BEGIN

  SELECT id INTO v_group_id FROM groups WHERE name = p_group_name;
  IF v_group_id IS NULL THEN
    RAISE EXCEPTION 'No ID found for %', p_group_name;
  ELSE
    FOR rec_person IN person_cur LOOP
      INSERT INTO people
        (party_type_id, group_id, first_name, last_name, created_at, updated_at)
      VALUES
        (v_party_type_id, v_group_id, rec_person.first_name, rec_person.last_name, now(), now())
      RETURNING id INTO v_party_id;

-- RAISE NOTICE 'Party ID is %', v_party_id;

      INSERT INTO addresses
        (party_id, address_type_id, street_address_1, city, county, state, postal_code, country, full_location, created_at, updated_at)
      VALUES
        (v_party_id, 
         v_addr_type_id, 
         TRIM(COALESCE(rec_person.street_number, '')||' '||
              COALESCE(rec_person.street_name, '')||' '||
              COALESCE(rec_person.street_type, '')||' '||
              COALESCE(rec_person.street_direction, '')||' '||
              COALESCE(rec_person.street_direction2, '')||' '||
              COALESCE(rec_person.unit_number, '')
         ),
         COALESCE(rec_person.city, ''),
         rec_person.county,
         COALESCE(rec_person.province_abbr, ''),
         COALESCE(rec_person.postal_code, ''),
         'USA',
         rec_person.address_combined,
         now(),
         now())
      RETURNING id INTO v_address_id;
   
-- RAISE NOTICE 'Address ID is %', v_address_id;

      UPDATE pp_extended_outcomes o
         SET address_id = v_address_id
       WHERE person_id = rec_person.id;

    END LOOP;

  END IF;
END;
$$
LANGUAGE plpgsql;
