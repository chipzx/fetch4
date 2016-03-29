class Kennel < ActiveRecord::Base
  include MultiTenant

  validates :name, :kennel_type_id, presence: true
  validates :name, uniqueness: {scope: [:building, :group_id] }

  def kennel_name
    full_name ? "#{building}-#{name}" : name
  end

  def self.new_kennel(name, group_id)
    k = Kennel.new
    k.name = name
    k.group_id = group_id
    k.kennel_type_id = KennelType.default_type.id
    return k
  end

end
