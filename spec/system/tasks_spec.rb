require 'rails_helper'
RSpec.describe 'タスク管理', type: :system do
  let :board_path do '/boards' end

  it 'トップページにはじめるボタンが表示されている' do
    visit root_path
    expect(page).to have_content('はじめる'), 'トップページにはじめるボタンが表示されていません'
  end

  it 'ボードページに戻るボタンが表示されている' do
    visit board_path
    expect(page).to have_content('戻る'), 'ボードページに戻るボタンが表示されていません'
  end

  it 'トップページからボードページに遷移できる' do
    visit root_path
    click_link 'はじめる'
    expect(current_path).to eq('/boards'), 'ボードページに遷移できていません'
  end

  it 'ボードページからトップページに遷移できる' do
    visit board_path
    click_link '戻る'
    expect(current_path).to eq('/'), 'トップページに遷移できていません'
  end

  it '作成したタスクがボードページに表示されている' do
    create(:task, title: 'Rubyのサンプルコードを書く')
    create(:task, title: 'Dockerを勉強する')
    visit board_path
    expect(page).to have_content('Rubyのサンプルコードを書く'), '作成したタスクがボードページに表示されていません'
    expect(page).to have_content('Dockerを勉強する'), '作成したタスクがボードページに表示されていません'
  end

end
