class Private::PrivateController < ApplicationController
  layout 'cim'
  before_action :check_access

  private

  def check_access
    return if controller_name == 'cim_inquiries'
    authenticate_user! if action_name != 'teaser'
  end

  def check_authorization
    return true if (action_name == 'teaser' or controller_name == 'cim_inquiry' or current_user.admin?)
    not_found unless current_user.authorized_for_cim?(cim: @cim)
  end

end
