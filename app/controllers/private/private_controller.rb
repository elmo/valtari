class Private::PrivateController < ApplicationController
  layout 'cim'
  before_action :set_devise_mapping
  before_action :authenticate_user!

  private

  def set_devise_mapping
    request.env["devise.mapping"] = Devise.mappings[:user]
  end

end
