class Dashboard < ActiveRecord::Base
  include ProvisionedCodeTable

  validates :name, :default_time_period, presence: true
  validates :name, uniqueness: { scope: :group_id }
end
