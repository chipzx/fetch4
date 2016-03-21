class IntakeMetric < ActiveRecord::Base
  include MultiTenant
  include DataSeries

  self.primary_key = :id

  def self.refresh
    Scenic.database.refresh_materialized_view(table_name, concurrently: false)
  end

  def self.intakes_by_day
    return self.intakes_by_period(:day_of_year)
  end

  def self.intakes_by_week
    return self.intakes_by_period(:week)
  end
  
  def self.intakes_by_month
    return self.intakes_by_period(:month)
  end

  def self.intakes_by_quarter
    return self.intakes_by_period(:quarter)
  end

  def self.intakes_by_zip_code
    # "count_all" is the name of the column produced by the call to the count method
    by_zip_code = IntakeMetric.where("trackable_animal AND postal_code IS NOT NULL AND intake_type = ?", 'Stray').group(:postal_code).order("count_all DESC").limit(10).count
    return create_hc_series(by_zip_code)
  end

  private
  def readonly?
    true
  end

  def self.intakes_by_period(period)
    by_period = IntakeMetric.where("trackable_animal").group(:animal_type, :fiscal_year, period).order(:animal_type, :fiscal_year, period).count
    return create_hc_series(by_period)
  end

end
