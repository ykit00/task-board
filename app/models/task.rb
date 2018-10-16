class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30 }
  validates :description, length: { maximum: 100 }
  validate :deadline_is_not_past?

  scope :deadline_desc, -> { order(deadline: :asc) }

  private

  def deadline_is_not_past?
    errors.add(:deadline, 'は過去の日時を設定できません。') if deadline.present? && deadline.past?
  end
end
