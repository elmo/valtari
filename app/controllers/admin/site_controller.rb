class Admin::SiteController < Admin::AdminController
  def index
    redirect_to admin_businesses_path
  end
end
