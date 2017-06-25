class Private::DealRoomsController < ApplicationController
  layout 'deal_room'
  before_action :authenticate_user!
  before_action :set_deal_room, only: [:show, :edit, :update, :destroy]
  before_action :owner_required, only: [:edit, :update, :destroy]
  before_action :authorization_required, only: [:show]

  def index
    @deal_rooms = current_user.deal_rooms.page(params[:page]).per(10)
  end

  def show
    @deal_room_invitation = @deal_room.deal_room_invitations.new
    @deal_room_authorizations =  @deal_room.deal_room_authorizations.page(params[:page]).per(10)
  end

  def new
    @deal_room = current_user.deal_rooms.new
  end

  def edit
  end

  def create
    @deal_room = current_user.deal_rooms.new(deal_room_params)
    respond_to do |format|
      if @deal_room.save
        format.html { redirect_to private_deal_room_url(@deal_room), notice: 'Deal room was successfully created.' }
        format.json { render :show, status: :created, location: @deal_room }
      else
        format.html { render :new }
        format.json { render json: @deal_room.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @deal_room.update(deal_room_params)
        format.html { redirect_to private_deal_room_path(@deal_room) , notice: 'Deal room was successfully updated.' }
        format.json { render :show, status: :ok, location: @deal_room }
      else
        format.html { render :edit }
        format.json { render json: @deal_room.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @deal_room.destroy
    respond_to do |format|
      format.html { redirect_to private_deal_rooms_url, notice: 'Deal room was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def owner_required
      not_found unless current_user == @deal_room.user
    end

    def authorization_required
      return true if current_user == @deal_room.user
      not_found if @deal_room.authorized?(user: current_user)
    end

    def set_deal_room
      @deal_room = current_user.deal_rooms.find(params[:id])
    end

    def deal_room_params
      params.require(:deal_room).permit(:name)
    end

end
