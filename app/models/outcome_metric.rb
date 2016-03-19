class OutcomeMetric < ActiveRecord::Base
  include MultiTenant
  include DataSeries

  self.primary_key = :id

  @@days = [ nil, "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun" ]

  def self.refresh
    Scenic.database.refresh_materialized_view(table_name, concurrently: false)
  end

  def self.outcomes_by_day
    by_day = OutcomeMetric.where("trackable_animal").group(:animal_type, :fiscal_year, :day_of_year).order(:animal_type, :fiscal_year, :day_of_year).count
    return create_hc_series(by_day)
  end

  def self.outcomes_by_week
    by_week = OutcomeMetric.where("trackable_animal").group(:animal_type, :fiscal_year, :week).order(:animal_type, :fiscal_year, :week).count
    return create_hc_series(by_week)
  end
  
  def self.outcomes_by_month
    by_month = OutcomeMetric.where("trackable_animal").group(:animal_type, :fiscal_year, :month).order(:animal_type, :fiscal_year, :month).count
    return create_hc_series(by_month)
  end

  def self.outcomes_by_quarter
    by_month = OutcomeMetric.where("trackable_animal").group(:animal_type, :fiscal_year, :quarter).order(:animal_type, :fiscal_year, :quarter).count
    return create_hc_series(by_month)
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
    return create_hc_series(by_hour)
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

  private
  def readonly?
    true
  end

end
