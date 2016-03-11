CREATE OR REPLACE FUNCTION calc_outcome_age() RETURNS trigger AS $calc_outcome_age$
  BEGIN
    IF OLD.age IS NULL OR NEW.age IS NULL OR NEW.dob != OLD.dob OR NEW.outcome_date != OLD.outcome_date THEN
      NEW.age := calc_age(NEW.outcome_date, NEW.dob);
RAISE NOTICE 'OLD AGE: % TO age % outcome_date % dob %', OLD.age, NEW.age, NEW.outcome_date, NEW.dob;
    END IF;
    RETURN NEW;
  END
$calc_outcome_age$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS calc_outcome_age ON outcomes;
CREATE TRIGGER calc_outcome_age AFTER INSERT OR UPDATE ON outcomes
  FOR EACH ROW EXECUTE PROCEDURE calc_outcome_age();

