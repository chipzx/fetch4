class OutcomeType < MultiTenantBase
  # always filter query by group_id
  default_scope { self.current ? where('outcome_types.group_id = ?', self.current) : nil }
  validates :name, :group_id, presence: true
  validates :name, uniqueness: {scope: :group_id}

  def self.provision(root_id, new_group_id)
    defaults = OutcomeType.where('group_id = ?', root_id)
    raise Exception, "No default outcome types found" if defaults.size == 0
    defaults.to_a.each do |ot|
      new_ot = OutcomeType.new(:name => ot.name, :description => ot.description, :group_id => new_group_id)
      new_ot.save
    end
    unless Rails.env.test?
      new_types = OutcomeType.where('group_id = ?', new_group_id)
      raise Exception, "New types do not match defaults" if new_types.size != defaults.size
    end
  end
end
