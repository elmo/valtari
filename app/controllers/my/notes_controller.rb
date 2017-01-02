class My::NotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_notable, only: [:show, :edit, :update, :destroy, :create]
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  def index
    if @notable.present?
      @notes = @notable.notes.where(user_id: current_user.id).page(params[:page]).per(20)
    else
      @notes = current_user.notes.page(params[:page]).per(20)
    end
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
        format.html { redirect_to my_business_path(@note.notable), notice: 'Note was successfully created.' }
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
        format.html { redirect_to @note, notice: 'Note was successfully updated.' }
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
      format.html { redirect_to my_business_path(@note.notable), notice: 'Note was successfully created.' }
      format.json { head :no_content }
    end
  end

  private

    def set_notable
      @notable = Business.find(params[:business_id]) if params[:business_id].present?
    end

    def set_note
       @note = @notable.notes.find(params[:id])
    end

    def note_params
      params.require(:note).permit(:body)
    end

end
