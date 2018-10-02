require 'rails_helper'

describe Task do
  # 有効なファクトリを持つこと
  it "has a valid factory" do
    expect(FactoryBot.build(:task)).to be_valid
  end

  # タイトルがあれば有効な状態であること
  it "is valid with a title" do
    task = Task.new(
      title: "New Task"
    )
    expect(task).to be_valid
  end

  # タイトルがなければ無効な状態であること
  it "is invalid without a title" do
    task = Task.new(title: nil)
    task.valid?
    expect(task.errors[:title]).to include("can't be blank")
  end
end
