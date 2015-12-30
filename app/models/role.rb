class Role < ActiveRecord::Base
  include ProvisionedCodeTable
  validates :description, :active, presence: true
end

