require 'rails_helper'
RSpec.describe 'タスク管理', type: :system do
  it 'トップページにはじめるボタンが表示されている' do
    visit root_path
    expect(page).to have_content('はじめる'), 'トップページにはじめるボタンが表示されていません'
  end

  it 'ボードページに戻るボタンが表示されている' do
    visit '/boards'
    expect(page).to have_content('戻る'), 'ボードページに戻るボタンが表示されていません'
  end

  it 'トップページからボードページに遷移できる' do
    visit root_path
    click_link 'はじめる'
    expect(current_path).to eq('/boards'), 'ボードページに遷移できていません'
  end

  it 'ボードページからトップページに遷移できる' do
    visit '/boards'
    click_link '戻る'
    expect(current_path).to eq('/'), 'トップページに遷移できていません'
  end
end
