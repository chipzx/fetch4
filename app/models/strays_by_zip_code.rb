class StraysByZipCode < ActiveRecord::Base
  include MultiTenant

  def self.stray_totals
    strays = StraysByZipCode.where("postal_code IS NOT NULL and intake_type = ?", 'Stray').order("total desc").limit(10)
    data = Array.new
    i = 0
    strays.to_a.each do |s|
      data << [ s.postal_code, s.total ]
    end
    return data
  end

end
