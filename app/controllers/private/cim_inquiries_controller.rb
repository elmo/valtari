class Private::CimInquiriesController < Private::PrivateController
  before_action :set_cim_inquiry, only: [:show]
  skip_before_filter :verify_authenticity_token

  def new
    @cim_inquiry = CimInquiry.new
  end

  def show
    @cim_inquiry = CimInquiry.find(params[:id])
  end

  def create
    @cim_inquiry = CimInquiry.new(cim_inquiry_params)

    respond_to do |format|
      if @cim_inquiry.save
        format.html { redirect_to teaser_private_cims_url, notice: 'Your inquiry has been received.' }
        format.js
      else
        format.html { render :new }
        format.js
      end
    end
  end

  private

  def set_cim_inquiry
    @cim_inquiry = CimInquiry.find(params[:id])
  end

  def cim_inquiry_params
    params.require(:cim_inquiry).permit(:name, :email, :phone, :company, :comment)
  end

end
