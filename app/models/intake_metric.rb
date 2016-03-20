class IntakeMetric < ActiveRecord::Base
  include MultiTenant
  include DataSeries

  self.primary_key = :id

  def self.refresh
    Scenic.database.refresh_materialized_view(table_name, concurrently: false)
  end

  def self.intakes_by_week
    by_week = IntakeMetric.where("trackable_animal").group(:animal_type, :fiscal_year, :week).order(:animal_type, :fiscal_year, :week).count
    return create_hc_series(by_week)
  end
  
  def self.intakes_by_month
    by_month = IntakeMetric.where("trackable_animal").group(:animal_type, :fiscal_year, :month).order(:animal_type, :fiscal_year, :month).count
    return create_hc_series(by_month)
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

end
