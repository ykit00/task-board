module LoginMacros
  def login(user)
    visit login_path
    fill_in "session_email", with: user.email
    fill_in "session_password", with: user.password
    click_button "ログイン"
    expect(page).to have_content 'ログインしました。'
  end

  def logout(user)
    visit "users/#{user.id}"
    click_link "ログアウト"
  end
end