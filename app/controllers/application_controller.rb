class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: "valtari", password: "interestingdude"
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :resource_name, :resource, :devise_mapping

  def after_sign_in_path_fer(resource)
    return profile_path if resource.organization.present? or resource.declined_to_state_organization?
    edit_user_registration_path
  end

  def not_found
    raise ActionController::RoutingError, 'Not Found'
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def set_user
    @user = current_user
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:phone, :email, :password, :password_confirmation, :first_name, :last_name ])
    devise_parameter_sanitizer.permit(:account_update, keys: [:phone, :email, :password, :password_confirmation, :first_name ])
  end

end
