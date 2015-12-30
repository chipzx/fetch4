class Privilege < ActiveRecord::Base
  include MultiTenant

  validates :user_id, :right_id, presence: true
  validates :user_id, uniqueness: { scope: [:right_id, :group_id] }

  has_one :users
  has_one :rights
end
