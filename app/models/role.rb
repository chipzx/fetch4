class Role < ActiveRecord::Base
  include ProvisionedCodeTable
  validates :description, :active, presence: true
  validates :name, uniqueness: { scope: :group_id }

  has_and_belongs_to_many :rights, :join_table => "role_rights"
end

