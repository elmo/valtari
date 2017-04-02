class Admin::VerificationsController < Admin::AdminController
  before_action :authenticate_user!
  before_action :set_verification, only: [:show, :edit, :update, :show, :complete]

  def index
    scope = Verification
    scope = scope.needs_assignment if params[:view].present?
    scope = scope.where(status: params[:status] ) if params[:status].present?
    scope = scope.where(assigned_to_user_id: params[:assigned]) if params[:assigned].present?
    scope = scope.where(completed_by_user_id: params[:completed]) if params[:completed].present?
    scope = scope.where(user_id: params[:user]) if params[:user].present?
    @verifications = scope.page(params[:page]).per(10)
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
