class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: "valtari", password: "interestingdude"
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    profile_path
  end

  def not_found
    raise ActionController::RoutingError, 'Not Found'
  end

end
