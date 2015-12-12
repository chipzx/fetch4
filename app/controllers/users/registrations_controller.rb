class Users::RegistrationsController < Devise::RegistrationsController
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    user_params = params[:user]

    @user = User.new()
    @user.email = user_params[:email]
    @user.password = user_params[:password]

    valid = confirm_passwords(user_params)
    if valid
      group = Group.find_by_name(user_params[:group_name])
      @user.group_id = group.id unless group.nil?
      valid = (!@user.group_id.nil? && @user.group_id != 0)
      if (!valid)
        flash[:alert] = 'Group name is not valid - check with your administrator'
      end
    else
      flash[:alert] = 'Passwords do not match - please re-enter'
    end

    respond_to do |format|
      if @user.save
        flash[:notice] = 'Check your email for your confirmation message'
        format.html { redirect_to "/", notice: 'Check your email for confirmation email' }
      else
        flash[:notice] = "Unable to register user"
        format.html { render action: "new" }
      end
    end

  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.for(:sign_up) << :attribute
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  private
  def confirm_passwords(user_params) 
    password1 = user_params[:password]
    password2 = user_params[:password_confirmation]
    return password1.eql? password2
  end

end
