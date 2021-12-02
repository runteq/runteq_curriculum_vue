require 'rails_helper'
RSpec.describe 'ユーザー機能', type: :system do
  let(:user) { create(:user) }

  it '未ログイン状態でヘッダーに「ユーザー登録」、「ログイン」ボタンが表示されている' do
    visit root_path
    expect(page).to have_content('ユーザー登録'), '未ログイン状態でヘッダーに「ユーザー登録」ボタンが表示されていません'
    expect(page).to have_content('ログイン'), '未ログイン状態でヘッダーに「ログイン」ボタンが表示されていません'
  end

  it 'ユーザー登録ページで各フィールドを入力して「登録」をクリックしたらユーザーが登録されている' do
    visit root_path
    click_link 'ユーザー登録'
    within "#register-form" do
      fill_in 'ユーザー名', with: 'test'
      fill_in 'メールアドレス', with: 'test@example.com'
      fill_in 'パスワード', with: 'password'
      fill_in 'パスワード（確認）', with: 'password'
      click_on '登録'
    end
    expect(page).to have_current_path('/login'), 'ログインページに遷移できていません'
  end

  it '登録済みユーザーでログインできる' do
    visit '/login'
    within "#login-form" do
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: '12345678'
      click_on 'ログイン'
    end
    expect(page).to have_current_path('/tasks'), 'タスクページに遷移できていません'
  end

  it 'ログイン状態でログアウトできる' do
    login_as(user)
    expect(page).to have_content('ログアウト'), 'ログイン状態でヘッダーに「ログアウト」ボタンが表示されていません'
    click_on 'ログアウト'
    expect(page).to have_current_path('/'), 'トップページに遷移できていません'
  end

  it '未ログイン状態でタスクページに遷移したら、ログインページにリダイレクトされる' do
    visit root_path
    click_on 'はじめる'
    expect(page).to have_current_path('/login'), 'ログインページに遷移できていません'
  end

  it 'ログイン状態でタスクページに遷移したら、タスクページが表示される' do
    login_as(user)
    visit root_path
    click_on 'はじめる'
    expect(page).to have_current_path('/tasks'), 'タスクページに遷移できていません'
  end
end

