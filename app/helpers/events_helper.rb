module EventsHelper

  def event_photo(event, size: :large, klass: nil)
    render partial: '/events/photo', locals:  {event: event, height: heights[size] } if event.photo.size > 0
  end

  def heights
     {
       tiny: '50',
       small: '100',
       medium: '200',
       large: '400'
     }
  end

end
