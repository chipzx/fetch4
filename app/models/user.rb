class User < ActiveRecord::Base
  include MultiTenant

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :roles, :join_table => 'user_roles'
  has_many :rights, :join_table => 'privileges'

  def self.is_user
    true
  end

  def group_name
    g = Group.find(self.group_id) unless self.group_id.nil?  
    g.nil? ? nil : g.name
  end
 
  def self.get_group_id(group_name)
    g = Group.find_by_name(group_name)
    g.nil? ? nil : g.id
  end
  
end
