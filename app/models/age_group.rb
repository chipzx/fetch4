class AgeGroup < ActiveRecord::Base
  
  validates :name, presence: true
end
