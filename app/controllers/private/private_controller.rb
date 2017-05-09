class Private::PrivateController < ApplicationController
  layout 'cim'
  before_action :check_access

  private

  def check_access
    authenticate_user! if action_name != 'teaser' and controller_name != 'cim_inquiry'
  end

  def check_authorization
    return true if (action_name == 'teaser' or controller_name == 'cim_inquiry' or current_user.admin?)
    not_found unless current_user.authorized_for_cim?(cim: @cim)
  end

end
