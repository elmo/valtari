class Private::GroupsController < Private::PrivateController
  layout 'deal_room'
  before_action :authenticate_user!
  before_action :set_deal_room, only: [:show]
  before_action :owner_required

  def show
    @group = params[:id]
  end

  private

  def owner_required
    not_found unless current_user == @deal_room.user
  end

  def set_deal_room
    @deal_room = DealRoom.friendly.find(params[:deal_room_id])
  end

end
