class AddStatusToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :status, :integer, default: 0, null: false
  end
end
