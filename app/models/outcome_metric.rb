class OutcomeMetric < ActiveRecord::Base
  include MultiTenant
  include DataSeries

  self.primary_key = :id

  @@days = [ nil, "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun" ]

  def self.refresh
    # make sure outcomes have intake dates (if available) so we can calc length of stay in outcome_metrics
    connection.execute(
"UPDATE outcomes o                                                                                           
    SET intake_date = i.intake_date, 
        intake_type_id = lookup_intake_type_id(i.intake_type, o.group_id) 
   FROM intake_metrics i
  WHERE o.animal_id = i.animal_id
    AND o.group_id = i.group_id 
    AND o.intake_date IS NULL
    AND i.intake_date = (SELECT MAX(i2.intake_date) 
                         FROM   intake_metrics i2
                         WHERE  i2.animal_id = i.animal_id
                           AND  i2.animal_id = o.animal_id
                           AND  i2.group_id = o.group_id
                           AND  i2.intake_date <= o.outcome_date)")

    Scenic.database.refresh_materialized_view(table_name, concurrently: false)
  end

  def self.outcomes_by_day
    return outcomes_by_period(:day_of_year)
  end

  def self.outcomes_by_week
    return outcomes_by_period(:week)
  end
  
  def self.outcomes_by_month
    return outcomes_by_period(:month)
  end

  def self.outcomes_by_quarter
    return outcomes_by_period(:quarter)
  end

  def self.outcomes_by_zip_code
    # "count_all" is the name of the column produced by the call to the count method
    by_zip_code = OutcomeMetric.where("trackable_animal AND postal_code IS NOT NULL").group(:postal_code, :fiscal_year).order("count_all DESC").limit(7).count
    return create_hc_series(by_zip_code)
  end

  def self.outcomes_by_gender
    by_gender = OutcomeMetric.where("trackable_animal and outcome_type IN ('Adoption') and gender NOT LIKE 'Unknown%'").group(:animal_type, :fiscal_year, :gender).order(:animal_type, :fiscal_year, :gender).count
    return create_hc_series(by_gender)
  end

  def self.adoptions_by_hour
    by_hour = OutcomeMetric.where("trackable_animal and outcome_type = 'Adoption'").group(:fiscal_year, :outcome_hour).order(:fiscal_year, :outcome_hour).count
    return create_hc_series(by_hour, :hour)
  end

  def self.adoptions_by_day_of_week
    by_dow = OutcomeMetric.where("trackable_animal and outcome_type = 'Adoption'").group(:fiscal_year, :day_of_week).order(:fiscal_year, :day_of_week).count
    by_dow = create_hc_series(by_dow)
    by_dow.each do |series|
      data = series["data"]
      data.each do |entry|
        entry[0] =  @@days[entry[0].to_i]
      end
    end
    return by_dow
  end

  def self.adoptions_by_length_of_stay
    length_of_stay = OutcomeMetric.where("trackable_animal AND outcome_type = 'Adoption' AND length_of_stay IS NOT NULL").group(:animal_type).order(:animal_type).average(:length_of_stay)
    return create_hc_series(length_of_stay)
  end

  def self.adoptions_by_age_groups
    los_by_age_group = OutcomeMetric.where("trackable_animal AND outcome_type = 'Adoption' AND age_group IS NOT NULL").group(:animal_type, :age_group).order(:animal_type, :age_group).average(:length_of_stay)
    return create_hc_series(los_by_age_group)
  end

  private
  def readonly?
    true
  end

  def self.outcomes_by_period(period)
    by_period = OutcomeMetric.where("trackable_animal").group(:animal_type, :fiscal_year, period).order(:animal_type, :fiscal_year, period).count
    return create_hc_series(by_period, period)
  end

end
