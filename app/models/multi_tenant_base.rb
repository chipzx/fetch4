class MultiTenantBase < ActiveRecord::Base
  self.abstract_class = true
  validates :group_id, presence: true
  
  before_save :set_group
  after_create :init

  def init
    puts 'Executed init'
    @user = nil
    @group_id = nil
  end

  def before_save
    puts 'Executed before save'
  end

  def self.current
    Thread.current['current_group']
  end

  def self.current=(group)
    Thread.current['current_group'] = group
    Thread.current['current_user'] = current_user   # this is from devise
  end

  def set_group_and_user
    set_group
    set_user
  end

  def group
    return @group_id
  end

  def set_group
    unless Thread.current['current_group'].nil?
      @group_id = Thread.current['current_group']
      logger.debug("Current group set to #{Thread.current['current_group']} from thread #{Thread.current}")
    end
  end

  def set_user
    unless Thread.current['current_group'].nil?
      @user = Thread.current['current_user']
      logger.debug("Current user set to #{Thread.current['current_user']} from thread #{Thread.current}")
    end
  end

end
