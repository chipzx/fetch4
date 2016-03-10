class OutcomeMetric < ActiveRecord::Base
  include MultiTenant
  include DataSeries

  self.primary_key = :id

  def self.refresh
    Scenic.database.refresh_materialized_view(table_name, concurrently: false)
  end

  def self.outcomes_by_day
    by_day = OutcomeMetric.where("trackable_animal and fiscal_year = 2015 and month = 7").group(:animal_type, :fiscal_year, :day_of_year).order(:animal_type, :fiscal_year, :day_of_year).count
    return create_series(by_day)
  end

  def self.outcomes_by_week
    by_week = OutcomeMetric.where("trackable_animal").group(:animal_type, :fiscal_year, :week).order(:animal_type, :fiscal_year, :week).count
    return create_series(by_week)
  end
  
  def self.outcomes_by_month
    by_month = OutcomeMetric.where("trackable_animal").group(:animal_type, :fiscal_year, :month).order(:animal_type, :fiscal_year, :month).count
    return create_series(by_month)
  end

  def self.outcomes_by_quarter
    by_month = OutcomeMetric.where("trackable_animal").group(:animal_type, :fiscal_year, :quarter).order(:animal_type, :fiscal_year, :quarter).count
    return create_series(by_month)
  end

  def self.outcomes_by_zip_code
    # "count_all" is the name of the column produced by the call to the count method
    by_zip_code = OutcomeMetric.where("trackable_animal AND postal_code IS NOT NULL").group(:postal_code, :fiscal_year).order("count_all DESC").limit(7).count
    return create_by_year_series(by_zip_code)
  end

  private
  def readonly?
    true
  end

end
