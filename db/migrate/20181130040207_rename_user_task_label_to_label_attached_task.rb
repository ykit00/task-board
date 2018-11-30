class RenameUserTaskLabelToLabelAttachedTask < ActiveRecord::Migration[5.2]
  def change
    rename_table :user_task_labels, :label_attached_tasks
  end
end
