class Task < ApplicationRecord
  belongs_to :user
  has_many :user_task_labels, dependent: :destroy

  validates :title, presence: true, length: { maximum: 30 }
  validates :description, length: { maximum: 100 }
  validate :deadline_is_not_past

  enum status: { not_yet: 0, in_progress: 1, done: 2, pending: 3, discontinued: 4 }
  enum priority: { low: 1, middle: 2, high: 3 }

  def self.sort_tasks(column, direction)
    return order(created_at: :desc) unless column && direction
    case column
    when 'priority'
      order(priority: direction.to_sym)
    when 'created_at'
      order(created_at: direction.to_sym)
    when 'deadline'
      order(deadline: direction.to_sym)
    else
      order(created_at: :desc)
    end
  end

  def self.search_tasks(column, value)
    case column
    when 'title'
      where 'title LIKE ?', "%#{value}%"
    when 'status'
      where status: value
    when 'priority'
      where priority: value
    else
      self
    end
  end

  private

    def deadline_is_not_past
      errors.add(:deadline, 'は過去の日時を設定できません。') if deadline.present? && deadline.past?
    end
end
