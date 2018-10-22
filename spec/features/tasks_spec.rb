require 'rails_helper'

RSpec.feature "Tasks", type: :feature do
  scenario "creates a new task" do
    visit root_path
    click_link "新規作成"
    fill_in "タイトル", with: "Test Task"
    click_button "登録する"

    expect(page).to have_content "タスクを作成しました。"
    expect(page).to have_content "Test Task"
  end

  scenario "creates a new task with a description" do
    visit root_path
    click_link "新規作成"
    fill_in "タイトル", with: "Test Task"
    fill_in "説明", with: "Trying out Capybara"

    click_button "登録する"
    expect(page).to have_content "タスクを作成しました。"
    expect(page).to have_content "Test Task"

    click_link "Test Task"
    expect(page).to have_content "Test Task"
    expect(page).to have_content "Trying out Capybara"
  end

  scenario "creates a new task with a description and deadline" do
    visit root_path
    click_link "新規作成"
    fill_in "タイトル", with: "Test Task"
    fill_in "説明", with: "Trying out Capybara"
    fill_in "終了期限", with: "2050/01/01"

    click_button "登録する"
    expect(page).to have_content "タスクを作成しました。"
    expect(page).to have_content "Test Task"
    expect(page).to have_content "2050/01/01"

    click_link "Test Task"
    expect(page).to have_content "Test Task"
    expect(page).to have_content "Trying out Capybara"
    expect(page).to have_content "2050/01/01"

  end

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

    click_link "Test Task"
    expect(page).to have_content "Change"
  end

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

  scenario "tasks sorted in descending order of creation date" do
    visit root_path
    click_link "新規作成"
    fill_in "タイトル", with: "Test Task1"
    fill_in "説明", with: "Trying out Capybara"
    click_button "登録する"

    click_link "新規作成"
    fill_in "タイトル", with: "Test Task2"
    fill_in "説明", with: "Trying out Capybara"
    click_button "登録する"

    click_link "新規作成"
    fill_in "タイトル", with: "Test Task3"
    fill_in "説明", with: "Trying out Capybara"
    click_button "登録する"

    tasks = all('ul > li')
    expect(tasks[0]).to have_content('Test Task3')
    expect(tasks[1]).to have_content('Test Task2')
    expect(tasks[2]).to have_content('Test Task1')
  end

  scenario "sort by created date descending button in descending order of created date" do
    visit root_path
    click_link "新規作成"
    fill_in "タイトル", with: "Test Task1"
    fill_in "説明", with: "Trying out Capybara"
    click_button "登録する"

    click_link "新規作成"
    fill_in "タイトル", with: "Test Task2"
    fill_in "説明", with: "Trying out Capybara"
    click_button "登録する"

    click_link "新規作成"
    fill_in "タイトル", with: "Test Task3"
    fill_in "説明", with: "Trying out Capybara"
    click_button "登録する"

    click_link "作成日:降順"

    tasks = all('ul > li')
    expect(tasks[0]).to have_content('Test Task3')
    expect(tasks[1]).to have_content('Test Task2')
    expect(tasks[2]).to have_content('Test Task1')
  end

  scenario "sort by deadline ascending button in ascending order of deadline" do
    visit root_path
    click_link "新規作成"
    fill_in "タイトル", with: "Test Task1"
    fill_in "説明", with: "Trying out Capybara"
    fill_in "終了期限", with: "2050/03/01"
    click_button "登録する"

    click_link "新規作成"
    fill_in "タイトル", with: "Test Task2"
    fill_in "説明", with: "Trying out Capybara"
    fill_in "終了期限", with: "2050/01/01"
    click_button "登録する"

    click_link "新規作成"
    fill_in "タイトル", with: "Test Task3"
    fill_in "説明", with: "Trying out Capybara"
    fill_in "終了期限", with: "2050/02/01"
    click_button "登録する"

    click_link "終了期限:昇順"

    tasks = all('ul > li')
    expect(tasks[0]).to have_content('Test Task2')
    expect(tasks[1]).to have_content('Test Task3')
    expect(tasks[2]).to have_content('Test Task1')
  end
end
