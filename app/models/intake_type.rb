class IntakeType < MultiTenantBase
  # always filter query by group_id
  default_scope { self.current ? where('intake_types.group_id = ?', self.current) : nil }

  validates :name, :group_id, presence: true
  validates :name, uniqueness: {scope: :group_id}

end
