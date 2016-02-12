class ServiceRequestStatusType < ActiveRecord::Base
  include ProvisionedCodeTable
  
  validates :name, :standard_name, presence: true
  validates :name, uniqueness: { scope: [ :name, :group_id ] }
end
