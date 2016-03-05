class Kennel < ActiveRecord::Base
  include MultiTenant

  validates :name, :kennel_type_id, presence: true
  validates :name, uniqueness: {scope: [:building, :group_id] }

  def kennel_name
    full_name ? "#{building}-#{name}" : name
  end

  def self.new_kennel(name)
    k = Kennel.new
    k.name = name
    k.kennel_type_id = KennelType.default_type.id
    k.save!
  end

end
