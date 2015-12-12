class Group < ActiveRecord::Base
  validates :name, :time_zone, presence: true
  validates :name, uniqueness: true
end
