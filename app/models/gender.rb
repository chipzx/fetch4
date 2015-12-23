class Gender < MultiTenantBase
  default_scope { self.current ? where('genders.group_id = ?', self.current) : nil }
  validates :name, :description, :group_id, presence: true
  validates :name, uniqueness: { scope: :group_id }
end
