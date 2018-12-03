class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_many :task_labels, foreign_key: :created_user_id, dependent: :destroy

  validates :name, presence: true, length: { maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  before_destroy :validate_last_one_administrator

  private

    def validate_last_one_administrator
      if admin? && User.where(admin: 'true').count <= 1
        # errors.add :base, '最後の1人の管理者ユーザーです。削除できません。'
        throw(:abort)
      end
    end


end
