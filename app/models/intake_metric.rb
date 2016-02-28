class IntakeMetric < ActiveRecord::Base
  include MultiTenant

  self.primary_key = :id

  def self.refresh
    Scenic.database.refresh_materialized_view(table_name, concurrently: false)
  end

  private
  def readonly?
    true
  end

end
