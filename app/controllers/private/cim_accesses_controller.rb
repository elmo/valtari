class Private::CimAccessesController < Private::PrivateController
  before_action :set_cim
  before_action :check_authorization

  def index
    scope = @cim_accesses= @cim.cim_accesses.includes(:user)
   if params[:user_id].present?
      @visiting_user = User.find(params[:user_id])
      scope = scope.where(user_id: @visiting_user.id)
    end
    @cim_accesses = scope.order(created_at: :desc).page(params[:page]).per(20)
  end

  private

  def set_cim
    @cim = Cim.friendly.find(params[:cim_id])
  end

end
