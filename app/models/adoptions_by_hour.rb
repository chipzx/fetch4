class AdoptionsByHour < ActiveRecord::Base
  include MultiTenant
  
  self.primary_key = [:hour, :group_id]

  def self.by_hour_totals
    ad = AdoptionsByHour.order("hour")
    data = Hash.new
    ad.to_a.each do |a|
      data[a.hour] = a.total
    end
    return data
  end

end
