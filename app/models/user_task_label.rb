class UserTaskLabel < ApplicationRecord
  belongs_to :task, foreign_key: :task_id
  belongs_to :task_label, foreign_key: :task_label_id

  validates :task_id, presence: true
  validates :task_label_id, presence: true
end
