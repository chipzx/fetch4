class OutcomesByZipCode < ActiveRecord::Base 
  include MultiTenant

  def self.by_zip_code
    series = Array.new
    outcomes = OutcomesByZipCode.all
    outcomes.to_a.each do |o|
      series << [ o.postal_code, o.total_outcomes ]
    end
    return series
  end

end
