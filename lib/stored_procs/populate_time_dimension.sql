CREATE OR REPLACE function populate_time_dimension(start_date DATE, end_date DATE) RETURNS VOID AS
$$
DECLARE
  the_date DATE;
BEGIN
  the_date := start_date;
  LOOP
    RAISE NOTICE 'Inserting date %', the_date;
    INSERT INTO time_dimension
      (calendar_date, 
       calendar_year, 
       month, 
       day_of_month, 
       day_of_week, 
       day_of_year, 
       week, 
       quarter
      )
    VALUES
      (the_date,
       EXTRACT(YEAR FROM the_date)::integer,
       EXTRACT(MONTH FROM the_date)::integer,
       EXTRACT(DAY FROM the_date)::integer,
       -- We want the ISO-8601 day of week, which starts on Monday
       EXTRACT(ISODOW FROM the_date)::integer,
       EXTRACT(DOY FROM the_date)::integer,
       EXTRACT(WEEK FROM the_date)::integer,
       EXTRACT(QUARTER FROM the_date)::integer
      );

    the_date := the_date + '1 day'::interval;
    EXIT WHEN the_date > end_date;
  END LOOP;
END;
$$ LANGUAGE plpgsql
