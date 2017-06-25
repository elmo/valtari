class Private::DealRoomAuthorizationsController < Private::PrivateController
  before_action :authenticate_user!
  before_action :set_deal_room
  before_action :set_deal_room_authorization, only: [:destroy]
  before_action :owner_required, only: [:destroy]

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
     @deal_room = current_user.deal_rooms.find(params[:deal_room_id])
   end

   def set_deal_room_authorization
     @deal_room_authorization = @deal_room.deal_room_authorizations.find(params[:id])
   end


end
