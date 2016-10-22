class Admin::AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin_or_editor_role

  private

  def require_admin_role
    not_found !current_user.admin? and !current_user.editor? and !current_user.master?
  end

end
