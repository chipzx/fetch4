class KennelType < MultiTenantBase

  default_scope { self.current ? where('kennel_types.group_id = ?', self.current) : nil }

  validates :name, :group_id, presence: true
  validates :name, uniqueness: {scope: :group_id}

  def self.provision(root_id, new_group_id)
    defaults = KennelType.where('group_id = ?', root_id)
    raise Exception, "No default kennel types found" if defaults.size == 0
    defaults.to_a.each do |at|
      new_at = KennelType.new(:name => at.name, :description => at.description, :group_id => new_group_id)
      new_at.save!
      puts("Saved new kennel type id: #{new_at.id} name: #{new_at.name} group_id: #{new_at.group_id}")
    end
    unless Rails.env.test?
      new_types = KennelType.where('group_id = ?', new_group_id)
      raise Exception, "Number of new types #{new_types.size} does not match number of default records #{defaults.size}" if new_types.size != defaults.size
    end
  end

end
