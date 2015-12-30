# Note: there is no need for right to be multitenant - the set of resources and actions is the same for all groups
class Right < ActiveRecord::Base
  validates :resource, :action, presence: true
  validates :resource, uniqueness: { scope: :resource}

  has_and_belongs_to_many :roles, :join_table => "role_rights"
end
