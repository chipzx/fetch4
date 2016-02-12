class AdoptionsByDay < ActiveRecord::Base
  include MultiTenant
  
  self.primary_key = [:day_of_week, :group_id]

  def self.by_day_totals
    ad = AdoptionsByDay.order("sort_order")
    data = Hash.new
    ad.to_a.each do |a|
      data[a.day_of_week] = a.number_adoptions
    end
    return data
  end

end
