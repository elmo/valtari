class Admin::VerificationsController < Admin::AdminController
  before_action :authenticate_user!
  before_action :set_verification, only: [:show, :edit, :update, :show, :complete]

  def index
    @verifications = Verification.all.page(params[:page]).per(20)
  end

  def show
  end

  def edit
  end

  def update
    assigned_to_user = User.find(verification_params[:assigned_user]) if verification_params[:assigned_user].present?
    @verification.assign_to(user: assigned_to_user) if assigned_to_user.present?
    respond_to do |format|
      format.html { redirect_to admin_verifications_path }
    end
  end

  def complete
    @verification.completed_by!(user: current_user)
    redirect_to admin_verifications_path( assigned_to: current_user.id), notice: "Verfication has been marked as complete."
  end

  private

  def set_verification
    @verification = Verification.find(params[:id])
  end

  def verification_params
    params.require(:verification).permit(:assigned_user, :status)
  end

end
