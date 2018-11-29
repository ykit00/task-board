class AddUniqueIndexToTaskLabels < ActiveRecord::Migration[5.2]
  def change
    add_index :task_labels, [:title, :created_user_id], unique: true
  end
end
