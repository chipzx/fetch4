class Gender < ActiveRecord::Base
  include ProvisionedCodeTable
  validates :description, presence: true
end
