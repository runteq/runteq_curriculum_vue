require 'rails_helper'
RSpec.describe 'タスク管理', type: :system do
  it 'トップページにはじめるボタンが表示されている' do
    visit root_path
    expect(page).to have_content('はじめる'), 'トップページにはじめるボタンが表示されていません'
  end

  it 'タスクページに戻るボタンが表示されている' do
    visit '/tasks'
    expect(page).to have_content('戻る'), 'タスクページに戻るボタンが表示されていません'
  end

  it 'トップページからタスクページに遷移できる' do
    visit root_path
    click_link 'はじめる'
    expect(current_path).to eq('/tasks'), 'タスクページに遷移できていません'
  end

  it 'タスクページからトップページに遷移できる' do
    visit '/tasks'
    click_link '戻る'
    expect(current_path).to eq('/'), 'トップページに遷移できていません'
  end

  it '作成したタスクがタスクページに表示されている' do
    create(:task, title: 'Rubyのサンプルコードを書く')
    create(:task, title: 'Dockerを勉強する')
    visit '/tasks'
    expect(page).to have_content('Rubyのサンプルコードを書く'), '作成したタスクがタスクページに表示されていません'
    expect(page).to have_content('Dockerを勉強する'), '作成したタスクがタスクページに表示されていません'
  end
end
