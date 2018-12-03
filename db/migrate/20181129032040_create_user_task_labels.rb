class CreateUserTaskLabels < ActiveRecord::Migration[5.2]
  def change
    create_table :user_task_labels do |t|
      t.integer :task_id, null: false
      t.integer :task_label_id, null: false

      t.timestamps
    end
  end
end
