class AddIndexToTaskTitle < ActiveRecord::Migration[5.2]
  def change
    add_index :tasks, :title
  end
end
