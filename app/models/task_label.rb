class TaskLabel < ApplicationRecord
  belongs_to :user, foreign_key: "created_user_id"
  has_many :user_task_labels, dependent: :destroy

  validates :title, presence: true, length: { maximum: 15 }
  validates :created_user_id, presence: true
end
