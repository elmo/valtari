class Private::SessionsController < Devise::SessionsController
  before_action :set_devise_mapping
  layout 'cim'

  def new
    super
  end

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    if !session[:return_to].blank?
      redirect_to session[:return_to]
      session[:return_to] = nil
    else
      respond_with resource, location:  after_cim_sign_in_path_for(resource)
    end
 end

  private

  def set_devise_mapping
    request.env["devise.mapping"] = Devise.mappings[:user]
  end

end

