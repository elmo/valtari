class My::EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = current_user.events.future( params[:start_date]  ? Date.parse(params[:start_date]) : Date.today )
  end

  def show
  end

  def new
    @event = current_user.events.new
  end

  def edit
  end

  def create
    @event = current_user.events.new(event_params)
    respond_to do |format|
      if @event.save
        format.html { redirect_to my_event_url(@event), notice: 'Event was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to my_event_url(@event) , notice: 'Event was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to my_events_url, notice: 'Event was successfully destroyed.' }
    end
  end

  private

    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:title, :start_time, :end_time)
    end
end