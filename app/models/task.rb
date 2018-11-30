class Task < ApplicationRecord
  belongs_to :user
  has_many :label_attached_tasks, dependent: :destroy
  has_many :task_labels, through: :label_attached_tasks

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

  # FIXME: 「これ」というタイトルをタイトル検索できない
  def self.search_tasks(column, value)
    case column
    when 'title'
      joins(:task_labels).where('tasks.title LIKE ? OR task_labels.title LIKE ?', "%#{value}%", "%#{value}%")
    when 'status'
      where status: value
    when 'priority'
      where priority: value
    else
      self
    end
  end

  def save_labels(labels)
    current_labels = task_labels.pluck(:title) unless task_labels.nil?
    delete_labels = current_labels - labels
    new_labels = labels - current_labels

    delete_labels.each do |label|
      delete_label = task_labels.find_by(title: label)
      delete_label.destroy
    end

    new_labels.each do |label|
      post_label = user.task_labels.find_or_create_by(title: label)
      task_labels << post_label
    end
  end

  def labels_as_string
    task_labels.pluck(:title).join(",")
  end

  private

    def deadline_is_not_past
      errors.add(:deadline, 'は過去の日時を設定できません。') if deadline.present? && deadline.past?
    end
end
