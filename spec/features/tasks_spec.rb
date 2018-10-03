require 'rails_helper'

RSpec.feature "Tasks", type: :feature do
  # 新しいタスクを作成する
  scenario "creates a new task" do
    visit root_path
    click_link "新規作成"
    fill_in "タイトル", with: "Test Task"
    fill_in "説明", with: "Trying out Capybara"
    click_button "登録する"

    expect(page).to have_content "タスクを作成しました。"
    expect(page).to have_content "Test Task"
    expect(page).to have_content "Trying out Capybara"
  end

  # タスクをの詳細を確認する
  scenario "show a task" do
    visit root_path
    click_link "新規作成"
    fill_in "タイトル", with: "Test Task"
    fill_in "説明", with: "Trying out Capybara"
    click_button "登録する"

    click_link "Test Task"
    expect(page).to have_content "Test Task"
    expect(page).to have_content "編集"
    expect(page).to have_content "戻る"
  end

  # タスクを編集する
  scenario "edit a task" do
    visit root_path
    click_link "新規作成"
    fill_in "タイトル", with: "Test Task"
    fill_in "説明", with: "Trying out Capybara"
    click_button "登録する"

    click_link "編集"
    fill_in "説明", with: "Change"
    click_button "更新する"

    expect(page).to have_content "タスクを更新しました。"
    expect(page).to have_content "Change"
  end

  # タスクを削除する
  scenario "delete a task" do
    visit root_path
    click_link "新規作成"
    fill_in "タイトル", with: "Test Task"
    fill_in "説明", with: "Trying out Capybara"
    click_button "登録する"

    click_link "削除"
    expect(page).to have_content "タスクを削除しました。"
    expect(page).to_not have_content "Test Task"
  end
end
