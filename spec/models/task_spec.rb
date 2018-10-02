require 'rails_helper'

RSpec.describe Task, type: :model do
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
