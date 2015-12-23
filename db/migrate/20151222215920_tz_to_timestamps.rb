class TzToTimestamps < ActiveRecord::Migration
  def up
    conn = ActiveRecord::Base.connection

    conn.execute("ALTER TABLE users ALTER COLUMN created_at SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE users ALTER COLUMN updated_at SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE users ALTER COLUMN reset_password_sent_at SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE users ALTER COLUMN remember_created_at SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE users ALTER COLUMN current_sign_in_at SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE users ALTER COLUMN last_sign_in_at SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE users ALTER COLUMN confirmed_at SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE users ALTER COLUMN confirmation_sent_at SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE users ALTER COLUMN locked_at SET DATA TYPE timestamp with time zone")

    conn.execute("ALTER TABLE groups ALTER COLUMN created_at SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE groups ALTER COLUMN updated_at SET DATA TYPE timestamp with time zone")

    conn.execute("ALTER TABLE animal_types ALTER COLUMN created_at SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE animal_types ALTER COLUMN updated_at SET DATA TYPE timestamp with time zone")

    conn.execute("ALTER TABLE intake_types ALTER COLUMN created_at SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE intake_types ALTER COLUMN updated_at SET DATA TYPE timestamp with time zone")

    conn.execute("ALTER TABLE outcome_types ALTER COLUMN created_at SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE outcome_types ALTER COLUMN updated_at SET DATA TYPE timestamp with time zone")

    conn.execute("ALTER TABLE animals ALTER COLUMN created_at SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE animals ALTER COLUMN updated_at SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE animals ALTER COLUMN dob SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE animals ALTER COLUMN intake_date SET DATA TYPE timestamp with time zone")
  end

  def down
    conn = ActiveRecord::Base.connection
    conn.execute("ALTER TABLE users ALTER COLUMN created_at SET DATA TYPE timestamp without time zone")
    conn.execute("ALTER TABLE users ALTER COLUMN updated_at SET DATA TYPE timestamp without time zone")
    conn.execute("ALTER TABLE users ALTER COLUMN reset_password_sent_at SET DATA TYPE timestamp without time zone")
    conn.execute("ALTER TABLE users ALTER COLUMN remember_created_at SET DATA TYPE timestamp without time zone")
    conn.execute("ALTER TABLE users ALTER COLUMN current_sign_in_at SET DATA TYPE timestamp without time zone")
    conn.execute("ALTER TABLE users ALTER COLUMN last_sign_in_at SET DATA TYPE timestamp without time zone")
    conn.execute("ALTER TABLE users ALTER COLUMN confirmed_at SET DATA TYPE timestamp without time zone")
    conn.execute("ALTER TABLE users ALTER COLUMN confirmation_sent_at SET DATA TYPE timestamp without time zone")
    conn.execute("ALTER TABLE users ALTER COLUMN locked_at SET DATA TYPE timestamp without time zone")

    conn.execute("ALTER TABLE groups ALTER COLUMN created_at SET DATA TYPE timestamp without time zone")
    conn.execute("ALTER TABLE groups ALTER COLUMN updated_at SET DATA TYPE timestamp without time zone")

    conn.execute("ALTER TABLE animal_types ALTER COLUMN created_at SET DATA TYPE timestamp without time zone")
    conn.execute("ALTER TABLE animal_types ALTER COLUMN updated_at SET DATA TYPE timestamp without time zone")

    conn.execute("ALTER TABLE intake_types ALTER COLUMN created_at SET DATA TYPE timestamp without time zone")
    conn.execute("ALTER TABLE intake_types ALTER COLUMN updated_at SET DATA TYPE timestamp without time zone")

    conn.execute("ALTER TABLE outcome_types ALTER COLUMN created_at SET DATA TYPE timestamp without time zone")
    conn.execute("ALTER TABLE outcome_types ALTER COLUMN updated_at SET DATA TYPE timestamp without time zone")

    conn.execute("ALTER TABLE animals ALTER COLUMN created_at SET DATA TYPE timestamp without time zone")
    conn.execute("ALTER TABLE animals ALTER COLUMN updated_at SET DATA TYPE timestamp without time zone")
    conn.execute("ALTER TABLE animals ALTER COLUMN dob SET DATA TYPE timestamp without time zone")
    conn.execute("ALTER TABLE animals ALTER COLUMN intake_date SET DATA TYPE timestamp without time zone")
  end
end
