class Private::DealRoomUploadsController < Private::PrivateController
  layout 'deal_room'
  before_action :authenticate_user!
  before_action :set_deal_room
  before_action :set_deal_room_upload, only: [:show, :destroy]

  def create
    @deal_room_upload = @deal_room.deal_room_uploads.new(deal_room_upload_params)
    @deal_room_upload.user = current_user
    respond_to do |format|
      params[:deal_room_upload]['upload'].each do  |upload|
        @deal_room_upload = @deal_room.deal_room_uploads.create!(upload: upload, original_file_name: upload.original_filename)
      end
      format.html { redirect_to private_deal_room_path(@deal_room), notice: 'Upload was successfully saved.' }
    end
  end

  def show
    respond_to do |format|
     format.html do
        send_data(@deal_room_upload.upload.read, filename: @deal_room_upload.original_file_name)
     end
    end
  end

  def destroy
    @deal_room_upload.destroy
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
    params.require(:deal_room_upload).permit( { uploads: [] } )
  end

end
