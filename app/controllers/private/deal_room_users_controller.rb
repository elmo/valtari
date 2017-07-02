class Private::DealRoomUsersController < Private::PrivateController
  layout 'deal_room'
  before_action :authenticate_user!
  before_action :set_user, only: [:index, :show, :edit, :update]
  before_action :set_deal_room

  def index
    scope = @deal_room.deal_room_authorizations
    @deal_room_authorizations = scope.page(params[:page]).per(10)
  end

  def show
     @user = User.friendly.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to private_deal_room_path(@deal_room), notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  private

   def set_deal_room
     @deal_room = DealRoom.friendly.find(params[:deal_room_id])
   end

   def user_params
     params.require(:user).permit(:first_name, :last_name,:avatar)
   end

end
