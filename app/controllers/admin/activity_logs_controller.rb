class Admin::ActivityLogsController < Admin::AdminController

  def index
    @activity_logs = ActivityLog.all.page(params[:page]).per(20)
  end

end
