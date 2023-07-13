require 'rails_helper'
RSpec.describe 'タスク管理', type: :system do
  it 'トップページが表示されている' do
    visit root_path
    expect(page).to have_content('はじめる'), 'はじめるボタンがトップページに表示されていません'
  end
end
