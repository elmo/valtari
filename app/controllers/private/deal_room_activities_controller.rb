class Private::DealRoomActivitiesController < Private::PrivateController
  layout 'deal_room'
  before_action :authenticate_user!
  before_action :set_deal_room

  def index
    scope = @deal_room.deal_room_activities
    scope = scope.where(['lower(message) like ? ', '%' + params[:q] + '%']) if params[:q].present?
    @deal_room_activities = scope.page(params[:page]).per(20)
    respond_to do |format|
      format.html
    end
  end

  private

  def set_deal_room
    @deal_room = DealRoom.friendly.find(params[:deal_room_id] )
  end


end
