class ApplicationController < ActionController::Base

  # Lazy way to add additional parameters to devise - see http://devise.plataformatec.com.br/#strong-parameters
#  before_action :configure_permitted_parameters, if :devise_controller?

  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  # Force authentication using Devise
  before_action :authenticate_user!

  protected

  # See http://devise.plataformatec.com.br/#strong-parameters
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :group_name
  end

end
