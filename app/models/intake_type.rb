class IntakeType < MultiTenantBase
  # always filter query by group_id
  default_scope { self.current ? where('intake_types.group_id = ?', self.current) : nil }

  validates :name, :group_id, presence: true
  validates :name, uniqueness: {scope: :group_id}

  def self.provision(root_id, new_group_id)
    defaults = IntakeType.where('group_id = ?', root_id)
    raise Exception, "No default intake types found" if defaults.size == 0
    defaults.to_a.each do |it|
      new_it = IntakeType.new(:name => it.name, :description => it.description, :group_id => new_group_id)
      new_it.save
      puts("Saved id: #{new_it.id} name: #{new_it.name} group_id: #{new_it.group}")
    end
    unless Rails.env.test?
      new_types = IntakeType.where('group_id = ?', new_group_id)
      raise Exception, "New types do not match defaults" if new_types.size != defaults.size
    end
  end

end
