module TasksHelper
  def set_sort_button_attr(title, column)
    direction = case request.fullpath.match(/(?<=sort_direction=)(asc|desc)/).to_s
                when 'desc'
                  'asc'
                when 'asc'
                  nil
                else
                  'desc'
                end

    column =  nil unless direction
    # direction = nil if column == request.fullpath.match(/(?<=sort_column=)(.*)(?=&)/).to_s

    @sort_attr = { title: title, column: column, direction: direction }
  end
end
