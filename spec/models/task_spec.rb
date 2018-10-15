require 'rails_helper'

describe Task do
  # 有効なファクトリを持つこと
  it "has a valid factory" do
    expect(FactoryBot.build(:task)).to be_valid
  end

  # タイトルがあれば有効な状態であること
  it "is valid with a title" do
    task = FactoryBot.build(:task)
    expect(task).to be_valid
  end

  # タイトルがなければ無効な状態であること
  it "is invalid without a title" do
    task = FactoryBot.build(:task, title: nil)
    task.valid?
    expect(task.errors[:title]).to include("を入力してください")
  end

  # 終了期限に過去の日付は無効であること
  it "is invalid set the past date" do
    task = FactoryBot.build(:task, deadline: "2000/01/01")
    task.valid?
    expect(task.errors[:deadline]).to include("は過去の日時を設定できません。")
  end
end
