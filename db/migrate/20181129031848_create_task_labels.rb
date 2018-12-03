class CreateTaskLabels < ActiveRecord::Migration[5.2]
  def change
    create_table :task_labels do |t|
      t.string :title, null: false
      t.integer :created_user_id, null: false

      t.timestamps
    end
  end
end
