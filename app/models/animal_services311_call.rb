class AnimalServices311Call < ActiveRecord::Base
  include MultiTenant

  validates :service_request_id, :service_request_type_id, :service_request_status_type_id, :status_change_date, :date_opened, :last_updated, presence: true
  validates :service_request_id, uniqueness: { scope: [ :group_id ] }

  belongs_to :address
  belongs_to :service_request_type
  belongs_to :service_request_status_type

  def self.within_radius(center_point, radius)
    addrs = Address.within_radius(center_point, radius)
    addr_ids = Array.new
    addrs.to_a.each do |a|
     addr_ids << a.id
    end
    self.where("address_id IN (?)", addr_ids)
  end

end
