require 'rails_helper'

RSpec.feature "Tasks", type: :feature do
  # 新しいタスクを作成する
  scenario "creates a new task" do
    visit root_path
    click_link "新規作成"
    fill_in "Title", with: "Test Task"
    fill_in "Description", with: "Trying out Capybara"
    click_button "Create Task"

    expect(page).to have_content "タスクを作成しました。"
    expect(page).to have_content "Test Task"
    expect(page).to have_content "Trying out Capybara"
  end
end
