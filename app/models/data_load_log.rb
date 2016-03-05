class DataLoadLog < ActiveRecord::Base
  include MultiTenant
  
  validates :data_load_id, :date_loaded, :data_as_of, :start_time, presence: true
  validates :data_load_id, uniqueness: { scope: [:start_time, :group_id] }

end
