class Admin::EventsController < Admin::AdminController
  before_action :authenticate_user!
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    scope = Event
    scope = scope.future(Time.zone.now) if params[:filter] == 'future'
    scope = scope.past(Time.zone.now) if params[:filter] == 'past'
    scope = scope.all if params[:filter].blank?
    @events = scope.page(params[:page]).per(10)
  end

  def new
    @event= Event.new(start_date: Time.zone.now.to_date,
                      start_time: "09:00 AM",
                      end_date: Time.zone.now.to_date,
                      end_time: "5:00 PM")
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to admin_event_path(@event), notice: 'Event was successfully updated.' }
        format.json { respond_with_bip(@event) }
      else
        format.html { render :edit }
        format.json { respond_with_bip(@event) }
      end
    end
  end

  def create
    @event = Event.new(event_params)
    respond_to do |format|
      if @event.save
        format.html { redirect_to admin_event_path(@event), notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to admin_events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :start_date, :start_time, :end_date, :end_time, :description, :location, :industry_classification_id, :tag_list, :photo)
  end

  def set_event
    @event = Event.find(params[:id])
  end
end