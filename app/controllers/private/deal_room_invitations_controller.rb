class Private::DealRoomInvitationsController < Private::PrivateController
  layout 'deal_room'
  before_action :authenticate_user!
  before_action :set_deal_room
  before_action :set_deal_room_invitation, only: [:show, :destroy, :resend]
  before_action :owner_or_authorized_required, only: [:create, :destroy]

  def index
    scope = @deal_room.deal_room_invitations
    if params[:q].present?
       scope = scope.where( ["lower(email) like ? ", '%' + params[:q].downcase + '%'] )
    end
    scope = scope.invited_by(current_user) if @deal_room.owned_by?(user: current_user)
    @deal_room_invitations = scope.page(params[:page]).per(10)
  end

  def show
  end

  def create
    @deal_room_invitation = @deal_room.deal_room_invitations.new(deal_room_invitation_params)
    @deal_room_invitation.inviter = current_user
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

  def resend
    @deal_room_invitation.resend
    respond_to do |format|
      format.html { redirect_to private_deal_room_path(@deal_room) , notice: "Invitation to #{@deal_room_invitation.email} resent." }
    end
  end

  private

   def owner_required
     not_found unless current_user == @deal_room.user
   end

   def owner_or_authorized_required
     return true if @deal_room.owned_by?(user: current_user)
     return true if @deal_room.deal_room_authorizations.where(user: current_user).exists?
     not_found
   end

   def set_deal_room
     @deal_room = DealRoom.friendly.find(params[:deal_room_id])
   end

   def set_deal_room_invitation
     @deal_room_invitation = @deal_room.deal_room_invitations.friendly.find(params[:id])
   end

   def deal_room_invitation_params
     params.require(:deal_room_invitation).permit(:email)
   end

end
