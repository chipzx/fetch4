class DataLoad < ActiveRecord::Base
  include MultiTenant

  validates :data_path, :data_load_type_id, :load_class, presence: true
  validates :data_load_type_id, uniqueness: { scope: :group_id }

end
