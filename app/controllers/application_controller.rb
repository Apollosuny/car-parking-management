class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!, :configure_permitted_parameters, if: :devise_controller?

  before_action do
    authenticate_admin! if request.path.start_with?('/admin')
  end

  def after_sign_in_path_for(resource)
    if current_user.role == 'admin' 
      rails_admin_path
    else
      root_path
    end
    resource.update(last_login: Time.now)
  end

  def after_sign_out_path_for(resource)
    new_user_session_path 
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
      devise_parameter_sanitizer.permit(:account_update, keys: [:username])
    end

  private 
    # Check is admin
    def authenticate_admin!
      redirect_to root_path, alert: 'Unauthorized access to admin interface' unless is_admin?
    end

    def is_admin?
      Devise.respond_to?(:current_user) && current_user.role == 'admin' 
    end
end

