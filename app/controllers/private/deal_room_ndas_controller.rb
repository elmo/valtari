class Private::DealRoomNdasController < ApplicationController
  layout 'deal_room'
  before_action :authenticate_user!
  before_action :set_deal_room
  before_action :set_deal_room_invitation
  after_action :log_activity, only: [:create]

  def new
    @deal_room_nda = current_user.deal_room_ndas.new
  end

  def create
    @deal_room_nda = current_user.deal_room_ndas.new(deal_room_nda_params)
    @deal_room_nda.deal_room = @deal_room
    @deal_room_nda.deal_room_invitation = @deal_room_invitation
    @deal_room_nda.ip_address = request.ip
    respond_to do |format|
      if @deal_room_nda.save
        format.html { redirect_to private_deal_room_path(@deal_room), notice: 'Your signature has been recorded. You are now bound by the terms of this NDA.' }
      else
        format.html { render :new }
      end
    end
  end

  private

    def set_deal_room_invitation
      @deal_room_invitation = current_user.deal_room_invitations.where(deal_room_id: @deal_room.id).first
    end

    def set_deal_room
      @deal_room = DealRoom.friendly.find(params[:deal_room_id])
    end

    def deal_room_nda_params
      params.require(:deal_room_nda).permit(:signature,:i_agree, :i_have_read)
    end

    def log_activity
      @deal_room.deal_room_activities.create(user: current_user, message: "#{current_user.email} signed NDA")
    end

end
