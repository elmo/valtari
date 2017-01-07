class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:show]

  def index
    @events = Event.future
  end

  def show
    def set_event
      @event = Event.find(params[:id])
    end
  end

end
