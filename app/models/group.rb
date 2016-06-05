class Group < ActiveRecord::Base
  validates :name, :time_zone, presence: true
  validates :name, uniqueness: true

  # Use this instead of find_by_name in rake tasks - sanitizes input
  def self.by_name(name)
    return Group.where(name: name)[0]
  end
end
