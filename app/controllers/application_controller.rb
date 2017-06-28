class ApplicationController < ActionController::Base
  #http_basic_authenticate_with name: "valtari", password: "interestingdude"
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :resource_name, :resource, :devise_mapping

  def after_sign_in_path_for(resource)
   if resource.deal_room_invitations.any?
     private_deal_room_path(resource.deal_room_invitations.last.deal_room)
   elsif resource.authorized_cims.any?
     after_cim_sign_in_path_for(resource)
   else
    businesses_path
   end
  end

  def after_sign_up_path_for(resource)
    edit_my_interests_path
  end

  def after_cim_sign_in_path_for(resource)
    welcome_private_cims_path
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
