class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30 }
  validates :description, length: { maximum: 100 }
  validate :deadline_is_not_past?

  scope :deadline_desc, -> { order(deadline: :asc) }

  enum status: { not_yet: 0, in_progress: 1, done: 2, pending: 3, discontinued: 4 }

  private

  def self.search(search)
    if search
      where ['title LIKE ?', "%#{search}"]
    else
      all
    end
  end

  def deadline_is_not_past?
    errors.add(:deadline, 'は過去の日時を設定できません。') if deadline.present? && deadline.past?
  end

end
