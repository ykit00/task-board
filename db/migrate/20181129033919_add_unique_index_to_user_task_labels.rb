class AddUniqueIndexToUserTaskLabels < ActiveRecord::Migration[5.2]
  def change
    add_index :user_task_labels, [:task_id, :task_label_id], unique: true
  end
end
