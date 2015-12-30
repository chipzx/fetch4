class RoleRight < ActiveRecord::Base
  validates :role_id, :right_id, presence: true
  validates :role_id, uniqueness: { scope: :right_id }

  has_one :roles
  has_one :rights
end
