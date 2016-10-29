module ApplicationHelper

  def sort_arrow_class(field)
    return '' unless params[:sort] == field
    (@sort_direction == 'asc') ? 'sorted-up' : 'sorted-down'
  end

end
