module MultiTenant
  extend ActiveSupport::Concern

  included do
    default_scope { self.group_id_scope }
    validates :group_id, presence: true
    before_save :before_save
    after_initialize :init
  end

  module ClassMethods
    def group_id_scope
       if (self.current)
        s = "#{table_name}.group_id = ?"
        where(s, self.current)
      else
        nil
      end
    end
 
    def current
      return Thread.current['current_group']
    end

    def current=(group)
      mutex = Mutex.new
      mutex.synchronize do
        Thread.current['current_group'] = group
        Thread.current['current_user'] = get_user 
      end
    end
    
    def get_user
      if ENV['RAILS_ENV'].eql?('production')
        return current_user
      else
        return User.all[0]
      end
    end
  end

  def init
    mutex = Mutex.new
    mutex.synchronize do
      self.group_id = set_group if self.group_id.nil?
      @user = set_user
    end
  end

  def before_save
    mutex = Mutex.new
    mutex.synchronize do
      set_group_and_user
    end
    raise Exception if group_id.nil?
  end

  def set_group_and_user
    set_group
    set_user
  end

  def group
    return @group_id
  end

  # This method should always be called in a synchronized block
  def set_group
    unless Thread.current['current_group'].nil?
      @group_id = Thread.current['current_group']
      logger.debug("Current group set to #{Thread.current['current_group']} from thread #{Thread.current}")
    end
  end

  # This method should always be called in a synchronized block
  def set_user
    unless Thread.current['current_group'].nil?
      @user = Thread.current['current_user']
      logger.debug("Current user set to #{Thread.current['current_user']} from thread #{Thread.current}")
    end
  end

end
