class Animal < MultiTenantBase

  default_scope { self.current ? where('animals.group_id = ?', self.current) : nil }

  validates :anumber, :animal_type_id, :intake_type_id, :group_id, presence: true
  validates :anumber, uniqueness: { scope: :group_id }

  
end
