class Outcome < ActiveRecord::Base
  include MultiTenant

  validates :animal_type_id, :animal_id, :outcome_type_id, :outcome_date, :gender_id, presence: true
  validates :animal_id, uniqueness: { scope: [ :group_id, :outcome_type_id, :outcome_date ] }

  belongs_to :address
  belongs_to :animal_type
  belongs_to :outcome_type
  belongs_to :gender
  belongs_to :group

  def self.within_radius(center_point, radius)
    addrs = Address.within_radius(center_point, radius)
    addr_ids = Array.new
    addrs.to_a.each do |a|
     addr_ids << a.id
    end
    self.where("address_id IN (?)", addr_ids)
  end
end
