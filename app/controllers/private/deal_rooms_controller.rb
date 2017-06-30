class Private::DealRoomsController < ApplicationController
  layout 'deal_room'
  before_action :authenticate_user!
  before_action :set_deal_room, only: [:show, :edit, :update, :destroy]
  before_action :owner_required, only: [:edit, :update, :destroy]
  before_action :user_full_name_required, only: [:show]
  before_action :nda_required, only: [:show]
  before_action :authorization_required, only: [:show]
  after_action :log_activity, only: [:show]

  def index
    @deal_rooms = current_user.deal_rooms.page(params[:page]).per(10)
  end

  def show
    @deal_room_invitation = @deal_room.deal_room_invitations.new
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
      not_found unless room_owner?
    end

    def nda_required
      return true if room_owner?
      if current_user.deal_room_ndas.where(deal_room: @deal_room).exists?
        return true
      else
        redirect_to new_private_deal_room_deal_room_nda_path(@deal_room), notice: "A signed NDA is required for admittance to this deal room." and return false
      end
    end

    def user_full_name_required
      return true if room_owner?
      if current_user.full_name.present?
        return true
      else
        redirect_to edit_private_deal_room_deal_room_user_path(@deal_room, current_user), notice: "Your first and last name is needed to proceed" and return false
      end
    end

    def authorization_required
      not_found unless @deal_room.authorized?(user: current_user)
    end

    def set_deal_room
      @deal_room = current_user.deal_rooms.friendly.find(params[:id]) if action_name != 'show'
      @deal_room = DealRoom.friendly.find(params[:id]) if action_name == 'show'
    end

    def deal_room_params
      params.require(:deal_room).permit(:name,:company_name)
    end

    def room_owner?
       current_user == @deal_room.user
    end

    def log_activity
      @deal_room.deal_room_activities.create(user: current_user, message: "#{current_user.email} entered room")
    end

end
