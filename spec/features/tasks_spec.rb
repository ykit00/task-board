require 'rails_helper'

# TODO: Adminに対応したSpecを書く
RSpec.feature "Tasks", type: :feature do

  let(:user_a) { FactoryBot.create(:user) }
  let(:user_b) { FactoryBot.create(:user) }

  scenario "user logs in" do
    visit login_path
    fill_in "session_email", with: user_a.email
    fill_in "session_password", with: user_a.password
    click_button "ログイン"

    expect(page).to have_content "ログインしました。"
    expect(page).to have_content user_a.name
  end

  context "logged in" do

    before do
      login(user_a)
    end

    scenario "creates a new task" do
      visit tasks_path
      click_link "新規タスク"
      fill_in "タイトル", with: "Test Task"
      click_button "作成"

      expect(page).to have_content "タスクを作成しました。"
      expect(page).to have_content "Test Task"
    end

    scenario "creates a new task with a description" do
      visit tasks_path
      click_link "新規タスク"
      fill_in "タイトル", with: "Test Task"
      fill_in "説明", with: "Trying out Capybara"

      click_button "作成"
      expect(page).to have_content "タスクを作成しました。"
      expect(page).to have_content "Test Task"

      click_link "Test Task"
      expect(page).to have_content "Test Task"
      expect(page).to have_content "Trying out Capybara"
    end

    scenario "creates a new task with a description and deadline" do
      visit tasks_path
      click_link "新規タスク"
      fill_in "タイトル", with: "Test Task"
      fill_in "説明", with: "Trying out Capybara"
      fill_in "終了期限", with: "2050/01/01"

      click_button "作成"
      expect(page).to have_content "タスクを作成しました。"
      expect(page).to have_content "Test Task"
      expect(page).to have_content "2050/01/01"

      click_link "Test Task"
      expect(page).to have_content "Test Task"
      expect(page).to have_content "Trying out Capybara"
      expect(page).to have_content "2050/01/01"

    end

    scenario "show a task" do
      visit tasks_path
      click_link "新規タスク"
      fill_in "タイトル", with: "Test Task"
      fill_in "説明", with: "Trying out Capybara"
      click_button "作成"

      click_link "Test Task"
      expect(page).to have_content "Test Task"
      expect(page).to have_content "編集"
      expect(page).to have_content "戻る"
    end

    scenario "edit a task" do
      visit tasks_path
      click_link "新規タスク"
      fill_in "タイトル", with: "Test Task"
      fill_in "説明", with: "Trying out Capybara"
      click_button "作成"

      click_link "編集"
      fill_in "説明", with: "Change"

      click_button "更新"
      expect(page).to have_content "タスクを更新しました。"

      click_link "Test Task"
      expect(page).to have_content "Change"
    end

    scenario "delete a task" do
      visit tasks_path
      click_link "新規タスク"
      fill_in "タイトル", with: "Test Task"
      fill_in "説明", with: "Trying out Capybara"
      click_button "作成"

      click_link "削除"
      expect(page).to have_content "タスクを削除しました。"
      expect(page).to_not have_content "Test Task"
    end

    scenario "tasks sorted in descending order of creation date" do
      visit tasks_path
      click_link "新規タスク"
      fill_in "タイトル", with: "Test Task1"
      fill_in "説明", with: "Trying out Capybara"
      click_button "作成"

      click_link "新規タスク"
      fill_in "タイトル", with: "Test Task2"
      fill_in "説明", with: "Trying out Capybara"
      click_button "作成"

      click_link "新規タスク"
      fill_in "タイトル", with: "Test Task3"
      fill_in "説明", with: "Trying out Capybara"
      click_button "作成"

      tasks = all('.tasks')
      expect(tasks[0]).to have_content('Test Task3')
      expect(tasks[1]).to have_content('Test Task2')
      expect(tasks[2]).to have_content('Test Task1')
    end

    scenario "sort by created_at" do
      visit tasks_path
      click_link "新規タスク"
      fill_in "タイトル", with: "Test Task1"
      fill_in "説明", with: "Trying out Capybara"
      click_button "作成"

      click_link "新規タスク"
      fill_in "タイトル", with: "Test Task2"
      fill_in "説明", with: "Trying out Capybara"
      click_button "作成"

      click_link "新規タスク"
      fill_in "タイトル", with: "Test Task3"
      fill_in "説明", with: "Trying out Capybara"
      click_button "作成"

      tasks = all('.tasks')
      expect(tasks[0]).to have_content('Test Task3')
      expect(tasks[1]).to have_content('Test Task2')
      expect(tasks[2]).to have_content('Test Task1')

      click_link "作成日"

      tasks = all('.tasks')
      expect(tasks[0]).to have_content('Test Task3')
      expect(tasks[1]).to have_content('Test Task2')
      expect(tasks[2]).to have_content('Test Task1')

      click_link "作成日"

      tasks = all('.tasks')
      expect(tasks[0]).to have_content('Test Task1')
      expect(tasks[1]).to have_content('Test Task2')
      expect(tasks[2]).to have_content('Test Task3')

      click_link "作成日"

      tasks = all('.tasks')
      expect(tasks[0]).to have_content('Test Task3')
      expect(tasks[1]).to have_content('Test Task2')
      expect(tasks[2]).to have_content('Test Task1')
    end

    scenario "sort by deadline" do
      visit tasks_path
      click_link "新規タスク"
      fill_in "タイトル", with: "Latest date"
      fill_in "説明", with: "Trying out Capybara"
      fill_in "終了期限", with: "2050/03/01"
      click_button "作成"

      click_link "新規タスク"
      fill_in "タイトル", with: "Earliest date"
      fill_in "説明", with: "Trying out Capybara"
      fill_in "終了期限", with: "2050/01/01"
      click_button "作成"

      click_link "新規タスク"
      fill_in "タイトル", with: "Between date"
      fill_in "説明", with: "Trying out Capybara"
      fill_in "終了期限", with: "2050/02/01"
      click_button "作成"

      tasks = all('.tasks')
      expect(tasks[0]).to have_content('Between date')
      expect(tasks[1]).to have_content('Earliest date')
      expect(tasks[2]).to have_content('Latest date')

      click_link "終了期限"

      tasks = all('.tasks')
      expect(tasks[0]).to have_content('Latest date')
      expect(tasks[1]).to have_content('Between date')
      expect(tasks[2]).to have_content('Earliest date')

      click_link "終了期限"

      tasks = all('.tasks')
      expect(tasks[0]).to have_content('Earliest date')
      expect(tasks[1]).to have_content('Between date')
      expect(tasks[2]).to have_content('Latest date')

      click_link "終了期限"

      tasks = all('.tasks')
      expect(tasks[0]).to have_content('Between date')
      expect(tasks[1]).to have_content('Earliest date')
      expect(tasks[2]).to have_content('Latest date')
    end

    scenario "sort by priority" do
      visit tasks_path
      click_link "新規タスク"
      fill_in "タイトル", with: "Middle priority"
      fill_in "説明", with: "Trying out Capybara"
      fill_in "終了期限", with: "2050/03/01"
      select "中", from: "task_priority"
      click_button "作成"

      click_link "新規タスク"
      fill_in "タイトル", with: "High priority"
      fill_in "説明", with: "Trying out Capybara"
      fill_in "終了期限", with: "2050/01/01"
      select "高", from: "task_priority"
      click_button "作成"

      click_link "新規タスク"
      fill_in "タイトル", with: "Low priority"
      fill_in "説明", with: "Trying out Capybara"
      fill_in "終了期限", with: "2050/02/01"
      select "低", from: "task_priority"
      click_button "作成"

      tasks = all('.tasks')
      expect(tasks[0]).to have_content('Low priority')
      expect(tasks[1]).to have_content('High priority')
      expect(tasks[2]).to have_content('Middle priority')

      click_link "優先度"

      tasks = all('.tasks')
      expect(tasks[0]).to have_content('High priority')
      expect(tasks[1]).to have_content('Middle priority')
      expect(tasks[2]).to have_content('Low priority')

      click_link "優先度"

      tasks = all('.tasks')
      expect(tasks[0]).to have_content('Low priority')
      expect(tasks[1]).to have_content('Middle priority')
      expect(tasks[2]).to have_content('High priority')

      click_link "優先度"

      tasks = all('.tasks')
      expect(tasks[0]).to have_content('Low priority')
      expect(tasks[1]).to have_content('High priority')
      expect(tasks[2]).to have_content('Middle priority')
    end

    scenario "search by title" do
      visit tasks_path
      click_link "新規タスク"
      fill_in "タイトル", with: "Test Task1"
      fill_in "説明", with: "Trying out Capybara"
      fill_in "終了期限", with: "2050/03/01"
      click_button "作成"

      click_link "新規タスク"
      fill_in "タイトル", with: "Test Task2"
      fill_in "説明", with: "Trying out Capybara"
      fill_in "終了期限", with: "2050/01/01"
      click_button "作成"

      click_link "新規タスク"
      fill_in "タイトル", with: "Test Task3"
      fill_in "説明", with: "Trying out Capybara"
      fill_in "終了期限", with: "2050/02/01"
      click_button "作成"

      fill_in "search_title", with: "3"
      click_button "検索"

      expect(page).to have_content "Test Task3"
      expect(page).to_not have_content "Test Task1"
      expect(page).to_not have_content "Test Task2"
    end

    scenario "search by status" do
      visit tasks_path
      click_link "新規タスク"
      fill_in "タイトル", with: "Test Task1"
      fill_in "説明", with: "Trying out Capybara"
      fill_in "終了期限", with: "2050/03/01"
      click_button "作成"
      click_link "Test Task1"
      click_link "編集"
      select "進行中", from: "task_status"
      click_button "更新"

      click_link "新規タスク"
      fill_in "タイトル", with: "Test Task2"
      fill_in "説明", with: "Trying out Capybara"
      fill_in "終了期限", with: "2050/03/01"
      click_button "作成"
      click_link "Test Task2"
      click_link "編集"
      select "完了", from: "task_status"
      click_button "更新"

      click_link "新規タスク"
      fill_in "タイトル", with: "Test Task3"
      fill_in "説明", with: "Trying out Capybara"
      fill_in "終了期限", with: "2050/03/01"
      click_button "作成"
      click_link "Test Task3"
      click_link "編集"
      select "保留", from: "task_status"
      click_button "更新"

      select "進行中", from: "search_status"
      click_button "検索"

      expect(page).to have_content "Test Task1"
      expect(page).to_not have_content "Test Task2"
      expect(page).to_not have_content "Test Task3"

      select "完了", from: "search_status"
      click_button "検索"

      expect(page).to have_content "Test Task2"
      expect(page).to_not have_content "Test Task1"
      expect(page).to_not have_content "Test Task3"

      select "保留", from: "search_status"
      click_button "検索"

      expect(page).to have_content "Test Task3"
      expect(page).to_not have_content "Test Task1"
      expect(page).to_not have_content "Test Task2"
    end

    scenario "search by priority" do
      visit tasks_path
      click_link "新規タスク"
      fill_in "タイトル", with: "Test Task1"
      fill_in "説明", with: "Trying out Capybara"
      fill_in "終了期限", with: "2050/03/01"
      click_button "作成"
      click_link "Test Task1"
      click_link "編集"
      select "高", from: "task_priority"
      click_button "更新"

      click_link "新規タスク"
      fill_in "タイトル", with: "Test Task2"
      fill_in "説明", with: "Trying out Capybara"
      fill_in "終了期限", with: "2050/03/01"
      click_button "作成"
      click_link "Test Task2"
      click_link "編集"
      select "中", from: "task_priority"
      click_button "更新"

      click_link "新規タスク"
      fill_in "タイトル", with: "Test Task3"
      fill_in "説明", with: "Trying out Capybara"
      fill_in "終了期限", with: "2050/03/01"
      click_button "作成"
      click_link "Test Task3"
      click_link "編集"
      select "低", from: "task_priority"
      click_button "更新"

      select "高", from: "search_priority"
      click_button "検索"

      expect(page).to have_content "Test Task1"
      expect(page).to_not have_content "Test Task2"
      expect(page).to_not have_content "Test Task3"

      select "中", from: "search_priority"
      click_button "検索"

      expect(page).to have_content "Test Task2"
      expect(page).to_not have_content "Test Task1"
      expect(page).to_not have_content "Test Task3"

      select "低", from: "search_priority"
      click_button "検索"

      expect(page).to have_content "Test Task3"
      expect(page).to_not have_content "Test Task1"
      expect(page).to_not have_content "Test Task2"
    end

    scenario "search and sort" do
      visit tasks_path
      click_link "新規タスク"
      fill_in "タイトル", with: "Test Task1"
      fill_in "説明", with: "Trying out Capybara"
      fill_in "終了期限", with: "2050/03/01"
      select "中", from: "task_priority"
      click_button "作成"

      click_link "新規タスク"
      fill_in "タイトル", with: "Test Task2"
      fill_in "説明", with: "Trying out Capybara"
      fill_in "終了期限", with: "2050/01/01"
      click_button "作成"

      click_link "新規タスク"
      fill_in "タイトル", with: "Test Task3"
      fill_in "説明", with: "Trying out Capybara"
      fill_in "終了期限", with: "2050/02/01"
      click_button "作成"

      click_link "新規タスク"
      fill_in "タイトル", with: "New Task1"
      fill_in "説明", with: "Trying out Capybara"
      fill_in "終了期限", with: "2050/02/01"
      select "低", from: "task_priority"
      click_button "作成"

      click_link "新規タスク"
      fill_in "タイトル", with: "Important Task1"
      fill_in "説明", with: "Trying out Capybara"
      fill_in "終了期限", with: "2050/01/01"
      select "高", from: "task_priority"
      click_button "作成"

      fill_in "search_title", with: "1"
      click_button "検索"

      expect(page).to have_content "Test Task1"
      expect(page).to have_content "New Task1"
      expect(page).to have_content "Important Task1"
      expect(page).to_not have_content "Test Task2"
      expect(page).to_not have_content "Test Task3"

      click_link "作成日"

      tasks = all('.tasks')
      expect(tasks[0]).to have_content('Important Task1')
      expect(tasks[1]).to have_content('New Task1')
      expect(tasks[2]).to have_content('Test Task1')
      expect(page).to_not have_content "Test Task2"
      expect(page).to_not have_content "Test Task3"

      click_link "終了期限"

      tasks = all('.tasks')
      expect(tasks[0]).to have_content('Test Task1')
      expect(tasks[1]).to have_content('New Task1')
      expect(tasks[2]).to have_content('Important Task1')
      expect(page).to_not have_content "Test Task2"
      expect(page).to_not have_content "Test Task3"

      click_link "優先度"

      tasks = all('.tasks')
      expect(tasks[0]).to have_content('Important Task1')
      expect(tasks[1]).to have_content('Test Task1')
      expect(tasks[2]).to have_content('New Task1')
      expect(page).to_not have_content "Test Task2"
      expect(page).to_not have_content "Test Task3"
    end

    scenario "not change the task created by another user" do
      visit tasks_path
      click_link "新規タスク"
      fill_in "タイトル", with: "Test Task1"
      fill_in "説明", with: "Trying out Capybara"
      fill_in "終了期限", with: "2050/03/01"
      select "中", from: "task_priority"
      click_button "作成"

      logout(user_a)
      login(user_b)

      visit tasks_path
      expect(page).to_not have_content "Test Task1"
      visit "tasks/#{user_a.tasks.last.id}"
      expect(page.status_code).to eq 404
    end
  end

  context "logged out" do
    scenario "visit tasks" do
      visit tasks_path
      expect(page).to_not have_content "新規タスク"
      expect(page).to have_content "ログイン"
    end

    scenario "edit tasks" do
      visit tasks_path
      expect(page).to_not have_content "編集"
      expect(page).to_not have_content "削除"
      expect(page).to have_content "ログイン"
      expect(page).to have_content "ユーザー登録"
    end
  end
end

