class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30 }
  validates :description, length: { maximum: 100 }
  validate :deadline_is_future?

  def deadline_is_future?
    if deadline.present? && deadline.past?
      errors.add(:deadline, "は過去の日時を設定できません。")
    end
  end
end
