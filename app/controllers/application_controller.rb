class ApplicationController < ActionController::Base

  # Lazy way to add additional parameters to devise - see http://devise.plataformatec.com.br/#strong-parameters
#  before_action :configure_permitted_parameters, if :devise_controller?

  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  # Force authentication using Devise
  before_action :authenticate_user!
  
  before_filter :set_current_group

  protected

  # See http://devise.plataformatec.com.br/#strong-parameters
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :group_name
  end

  def set_current_group
    unless ENV['RAILS_ENV'] == 'test' || current_user.nil?
      Thread.current['current_group'] = current_user.group_id
      Thread.current['current_user'] = current_user
    end
  end
end
