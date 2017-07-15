class Private::NotesController < Private::PrivateController
  before_action :authenticate_user!
  before_action :set_notable, only: [:index, :show, :edit, :update, :destroy, :create]
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  def index
    @notes = @notable.notes.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
  end

  def new
    @note = @notable.notes.new
  end

  def edit
  end

  def create
    @note = @notable.notes.new(note_params)
    @note.user = current_user
    respond_to do |format|
      if @note.save
        format.html { redirect_back(fallback_location:  polymorphic_url([:private, @notable, @note]), notice: 'Note was successfully saved.') }
        format.json { render :show, status: :created, location: @note }
      else
        format.html { render :new }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_back(fallback_location:  polymorphic_url([:private, @notable, @note]), notice: 'Note was successfully update.') }
        format.json { respond_with_bip(@note) }
      else
        format.html { render :edit }
        format.json { respond_with_bip(@note) }
      end
    end
  end

  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_back(fallback_location:  polymorphic_url([:private, @notable, @note]), notice: 'Note was successfully deleted.') }
      format.json { head :no_content }
    end
  end

  private

    def set_notable
      @notable = DealRoom.friendly.find(params[:deal_room_id]) if params[:deal_room_id].present?
      @notable = DealRoomUpload.find(params[:deal_room_upload_id]) if params[:deal_room_upload_id].present?
    end

    def set_note
       @note = @notable.notes.find(params[:id])
    end

    def note_params
      params.require(:note).permit(:body)
    end

end
