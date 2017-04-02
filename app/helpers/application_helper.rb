module ApplicationHelper

  def sort_arrow_class(field)
    return '' unless params[:sort] == field
    (@sort_direction == 'asc') ? 'sorted-up' : 'sorted-down'
  end

  def date_and_time_format
     "%m-%d-%Y %H:%M %p"
  end

  def date_format
    "%m-%d-%Y"
  end

  def format_date(date)
    date.strftime(date_format)
  end

  def industry_classification_thumbnail_image(industry_classification)
    image_tag("industry_thumbs/#{industry_classification.name.downcase.underscore}.jpg", class: 'center-cropped')
  end

end
