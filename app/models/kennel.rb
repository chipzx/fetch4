class Kennel < ActiveRecord::Base
  include MultiTenant

  validates :name, presence: true
  validates :name, uniqueness: {scope: [:building, :group_id] }

  def kennel_name
    full_name ? "#{building}-#{name}" : name
  end

end
