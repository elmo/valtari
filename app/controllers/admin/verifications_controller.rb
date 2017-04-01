class Admin::VerificationsController < Admin::AdminController
  before_action :authenticate_user!
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @verifications = Verification.all.page(params[:page]).per(20)
  end

  def edit
  end

  private

  def set_verification
    @verification = Verification.find(params[:id])
  end

  def verification_params
    params.require(:verification).permit(:assigned_to, :status)
  end

end
