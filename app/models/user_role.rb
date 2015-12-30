class UserRole < ActiveRecord::Base
  include MultiTenant
  validates :user_id, :role_id, presence: true
  validates :user_id, uniqueness: { scope: [:role_id, :group_id] }

  has_one :users
  has_one :roles
end
