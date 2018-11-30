class TaskLabel < ApplicationRecord
  belongs_to :user, foreign_key: :created_user_id
  has_many :label_attached_tasks, dependent: :destroy

  validates :title, presence: true, length: { maximum: 15 }
end
