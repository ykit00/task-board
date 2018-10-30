class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30 }
  validates :description, length: { maximum: 100 }
  validate :deadline_is_not_past

  enum status: { not_yet: 0, in_progress: 1, done: 2, pending: 3, discontinued: 4 }

  scope :sort_by_created_at_desc, -> { order(created_at: :desc) }
  scope :sort_by_deadline_asc, -> { order(deadline: :asc) }
  scope :search_by_title, ->(title) { where 'lower(title) LIKE ?', "%#{title.downcase}%" }
  scope :search_by_status, ->(status) { where status: status }


  private

    def deadline_is_not_past
      errors.add(:deadline, 'は過去の日時を設定できません。') if deadline.present? && deadline.past?
    end

end
