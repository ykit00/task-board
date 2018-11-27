module TasksHelper
  def set_sort_button_attr(title, column)
    if params[:sort_column].nil? && params[:sort_direction].nil?
      direction = 'desc'
      button = 'neutral'
    elsif params[:sort_column] == column && params[:sort_direction] == 'desc'
      direction = 'asc'
      button = 'down'
    elsif params[:sort_column] == column && params[:sort_direction] == 'asc'
      column = nil
      direction = nil
      button = 'up'
    else
      direction = 'desc'
      button = 'neutral'
    end

    @sort_attr = { title: title, column: column, direction: direction, button: button }
  end
end
