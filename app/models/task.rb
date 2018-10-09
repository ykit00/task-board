class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30 }
  validates :description, length: { maximum: 100 }
  validate :deadline_is_not_past?

  scope :deadline, -> { ofder(deadline: :asc) }

  def deadline_is_not_past?
    if deadline.present? && deadline.past?
      errors.add(:deadline, "は過去の日時を設定できません。")
    end
  end
end
