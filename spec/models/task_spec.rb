require 'rails_helper'

describe Task do
  let(:user) { FactoryBot.create(:user) }

  # 有効なファクトリを持つこと
  it "has a valid factory" do
    expect(FactoryBot.build(:task, user_id: user.id)).to be_valid
  end

  # タイトルがあれば有効な状態であること
  it "is valid with a title" do
    task = FactoryBot.build(:task, user_id: user.id)

    expect(task).to be_valid
  end

  # タイトルがなければ無効な状態であること
  it "is invalid without a title" do
    task = FactoryBot.build(:task, title: nil, user_id: user.id)
    task.valid?

    expect(task.errors[:title]).to include("を入力してください")
  end

  # 終了期限に過去の日付は無効であること
  it "is invalid set the past date" do
    task = FactoryBot.build(:task, deadline: "2000/01/01", user_id: user.id)
    task.valid?

    expect(task.errors[:deadline]).to include("は過去の日時を設定できません。")
  end

  # 検索文字列に一致するタスクを返すこと
  it "returns tasks that match the search term" do
    task1 = Task.create(title: "task1", user_id: user.id)
    task2 = Task.create(title: "task2", user_id: user.id)
    task3 = Task.create(title: "task3", user_id: user.id)

    expect(Task.search_tasks("title", "task1")).to include(task1)
    expect(Task.search_tasks("title", "task1")).to_not include(task2, task3)
    expect(Task.search_tasks("title", "task")).to include(task1, task2, task3)
    expect(Task.search_tasks("title", "menu")).to_not include(task1, task2, task3)

  end
end
