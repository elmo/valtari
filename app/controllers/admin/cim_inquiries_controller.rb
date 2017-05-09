class Admin::CimInquiriesController < Admin::AdminController

  def index
    @cim_inquiries = CimInquiry.page(params[:page]).per(10)
  end

end
