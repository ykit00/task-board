module TasksHelper
  def set_sort_button_attr(title, column)
    direction = 'desc'
    button = 'neutral'

    if params[:sort_column] == column
      if params[:sort_direction] == 'desc'
        direction = 'asc'
        button = 'down'
      elsif params[:sort_direction] == 'asc'
        column = nil
        direction = nil
        button = 'up'
      end
    end

    { title: title, column: column, direction: direction, button: button }
  end
end
