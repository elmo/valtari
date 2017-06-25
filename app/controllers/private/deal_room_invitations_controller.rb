class Private::DealRoomInvitationsController < Private::PrivateController
  before_action :authenticate_user!
  before_action :set_deal_room
  before_action :set_deal_room_invitation, only: [:show, :destroy]
  before_action :owner_required, only: [:create, :destroy]

  def show
  end

  def create
    @deal_room_invitation = @deal_room.deal_room_invitations.new(deal_room_invitation_params)
    respond_to do |format|
      if @deal_room_invitation.save
        format.html { redirect_to private_deal_room_path(@deal_room) , notice: "Invitation was successfully created." }
      else
        format.html { render :new }
      end
    end
  end

  def destroy
    @deal_room_invitation.destroy
    respond_to do |format|
      format.html { redirect_to private_deal_room_path(@deal_room) , notice: "Invitation was successfully deleted." }
    end
  end

  private

   def owner_required
     not_found unless current_user == @deal_room.user
   end

   def set_deal_room
     @deal_room = current_user.deal_rooms.find(params[:deal_room_id])
   end

   def set_deal_room_invitation
     @deal_room_invitation = @deal_room.deal_room_invitations.find(params[:id])
   end

   def deal_room_invitation_params
     params.require(:deal_room_invitation).permit(:email)
   end

end
