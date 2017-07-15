class Private::DealRoomAuthorizationsController < Private::PrivateController
  layout 'deal_room'
  before_action :authenticate_user!
  before_action :set_deal_room, only: [:destroy,:index]
  before_action :set_deal_room_authorization, only: [:destroy]
  before_action :owner_required, only: [:destroy]


  def index
   #deal_room_authorizations = deal_room.deal_room_authorizations.accepted_and_invited_by(deal_room, current_user).page(params[:authorization_page]).per(20)
    scope = @deal_room.deal_room_authorizations.includes(:user)
    @deal_room_authorizations = scope.page(params[:page]).per(10)
  end

  def destroy
    @deal_room_authorization.destroy
    respond_to do |format|
      format.html { redirect_to private_deal_room_path(@deal_room) , notice: "Authorization was successfully deleted." }
    end
  end

  private

   def owner_required
     not_found unless current_user == @deal_room.user
   end

   def set_deal_room
     @deal_room = DealRoom.friendly.find(params[:deal_room_id])
   end

   def set_deal_room_authorization
     @deal_room_authorization = @deal_room.deal_room_authorizations.find(params[:id])
   end


end
