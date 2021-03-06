class Private::DealRoomUploadsController < Private::PrivateController
  layout 'deal_room'
  before_action :authenticate_user!
  before_action :set_deal_room
  before_action :set_deal_room_upload, only: [:show, :destroy]

  def index
    @group = params[:group]
    scope = @deal_room.deal_room_uploads
    scope = scope.where( ["lower(original_file_name) like ? ", '%' + params[:q].downcase + '%'] ) if params[:q].present?
    @deal_room_uploads = scope.page(params[:page]).per(10)
  end

  def create
    @deal_room_upload = @deal_room.deal_room_uploads.new(deal_room_upload_params)
    respond_to do |format|
      params[:deal_room_upload]['upload'].each do  |upload|
        @deal_room.deal_room_uploads.create!(upload: upload, original_file_name: upload.original_filename, user: current_user, group: deal_room_upload_params[:group] )
      end
      format.html { redirect_back( fallback_location: private_deal_room_path(@deal_room), notice: 'Upload was successfully saved.' ) }
      format.js
    end
  end

  def show
   @deal_room.deal_room_activities.create(user: current_user, message: "#{current_user.email} viewed: #{@deal_room_upload.original_file_name}" )
    respond_to do |format|
     format.html do
        send_data(@deal_room_upload.upload.read, filename: @deal_room_upload.original_file_name)
     end
    end
  end

  def destroy
    @deal_room_upload.destroy
    @deal_room.deal_room_activities.create(user: current_user, message: "#{current_user.email} deleted: #{@deal_room_upload.original_file_name}")
    respond_to do |format|
      format.html { redirect_to private_deal_room_path(@deal_room), notice: 'Upload was successfully deleted.' }
    end
  end

  private

  def set_deal_room
    @deal_room = DealRoom.friendly.find(params[:deal_room_id] )
  end

  def set_deal_room_upload
    @deal_room_upload = @deal_room.deal_room_uploads.friendly.find(params[:id])
  end

  def deal_room_upload_params
    params.require(:deal_room_upload).permit(:group, uploads: [] )
  end


end
