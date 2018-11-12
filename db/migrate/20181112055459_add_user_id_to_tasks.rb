class AddUserIdToTasks < ActiveRecord::Migration[5.2]
  def up
    add_reference :tasks, :user, index: true
  end

  def down
    remove_reference :tasks, :user, index: true
  end
end
