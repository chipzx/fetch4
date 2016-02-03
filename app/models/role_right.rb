class RoleRight < ActiveRecord::Base
  include MultiTenant
  validates :role_id, :right_id, presence: true
  validates :role_id, uniqueness: { scope: [:right_id, :group_id] }

  has_one :roles
  has_one :rights

  def self.provision(root_id, new_group_id)
    roots = RoleRight.unscope(:where).where('group_id = ?', root_id)
    if (roots.size > 0)
      roots.to_a.each do |r|
        rr = RoleRight.new
        rr.role_id = r.role_id
        rr.right_id = r.right_id
        rr.group_id = new_group_id
        rr.save
      end
    end
  end

end
