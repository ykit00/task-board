class Task < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 30 }
  validates :description, length: { maximum: 100 }
  validate :deadline_is_not_past

  enum status: { not_yet: 0, in_progress: 1, done: 2, pending: 3, discontinued: 4 }
  enum priority: { low: 1, middle: 2, high: 3 }

  def self.sort_tasks(column, direction)
    return order(created_at: :desc) unless column && direction
    order(column + ' ' + direction + ' NULLS LAST')
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
