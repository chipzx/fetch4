class Kennel < MultiTenantBase
  default_scope { self.current ? where('kennels.group_id = ?', self.current) : nil }
  validates :name, :group_id, presence: true
  validates :name, uniqueness: {scope: [:building, :group_id] }

  def kennel_name
    full_name ? "#{building}-#{name}" : name
  end

end
