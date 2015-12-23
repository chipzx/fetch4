class Gender < MultiTenantBase
  default_scope { self.current ? where('genders.group_id = ?', self.current) : nil }
  validates :name, :description, :group_id, presence: true
  validates :name, uniqueness: { scope: :group_id }

  def self.provision(root_id, new_group_id)
    defaults = Gender.where('group_id = ?', root_id)
    raise Exception, "No default gender types found" if defaults.size == 0
    defaults.to_a.each do |g|
      new_g = Gender.new(:name => g.name, :description => g.description, :group_id => new_group_id)
      new_g.save
    end
    unless Rails.env.test?
      new_types = OutcomeType.where('group_id = ?', new_group_id)
      raise Exception, "New types do not match defaults" if new_types.size != defaults.size
    end
  end

end
