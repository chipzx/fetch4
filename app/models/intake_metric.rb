class IntakeMetric < ActiveRecord::Base
  include MultiTenant
  include DataSeries

  self.primary_key = :id

  def self.refresh
    Scenic.database.refresh_materialized_view(table_name, concurrently: false)
  end

  def self.intakes_by_week
    by_week = IntakeMetric.where("trackable_animal").group(:animal_type, :fiscal_year, :week).order(:animal_type, :fiscal_year, :week).count
    return create_series(by_week)
  end
  
  def self.intakes_by_month
    by_month = IntakeMetric.where("trackable_animal").group(:animal_type, :fiscal_year, :month).order(:animal_type, :fiscal_year, :month).count
    return create_series(by_month)
  end


  private
  def readonly?
    true
  end

end
