require 'rails_helper'
RSpec.describe 'タスク管理', type: :system do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  it 'トップページにはじめるボタンが表示されている' do
    visit root_path
    expect(page).to have_content('はじめる'), 'トップページにはじめるボタンが表示されていません'
  end
=begin 課題10からは認証が加わるのでコメントアウト
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

  it 'タスクをクリックして、タスク詳細モーダルが表示されている' do
    task = create(:task, title: 'JavaScriptのfor文を理解する', description: 'JavaScript本格入門の第二章に書かれているfor文を読んで理解する')
    visit '/tasks'
    find("#task-#{task.id}").click
    within "#task-detail-modal-#{task.id}" do
      expect(page).to have_content('JavaScriptのfor文を理解する'), 'タスク詳細モーダルにタイトルが表示されていません'
      expect(page).to have_content('JavaScript本格入門の第二章に書かれているfor文を読んで理解する'), 'タスク詳細モーダルに説明文が表示されていません'
    end
  end

  it 'タスク詳細モーダル表示状態で「閉じる」をクリックするとモーダルが非表示になる' do
    task = create(:task, title: 'JavaScriptのfor文を理解する', description: 'JavaScript本格入門の第二章に書かれているfor文を読んで理解する')
    visit '/tasks'
    find("#task-#{task.id}").click
    within "#task-detail-modal-#{task.id}" do
      click_button('閉じる')
    end
    expect(page).to have_no_button('閉じる'), 'タスク詳細モーダルが閉じられていません'
  end

  it 'タスク追加をクリックして、タスク追加モーダルが表示されている' do
    visit '/tasks'
    click_button('タスクを追加')
    expect(page).to have_selector('#task-create-modal'), 'タスク追加モーダルが表示されていません'
  end

  it 'タスク追加モーダル表示状態で「閉じる」をクリックするとモーダルが非表示になる' do
    visit '/tasks'
    click_button('タスクを追加')
    expect(page).to have_selector('#task-create-modal'), 'タスク追加モーダルが表示されていません'
    click_button('閉じる')
    expect(page).to_not have_selector('#task-create-modal'), 'タスク追加モーダルが閉じられていません'
  end

  it 'タイトルと説明文とステータスを入力して「追加」をクリックしたら新しいタスクが追加されている' do
    visit '/tasks'
    click_button('タスクを追加')
    fill_in 'タイトル', with: 'JSを勉強する'
    fill_in '説明文', with: 'ES6完全に理解する'
    select 'TODO', from: 'ステータス'
    click_on '追加'
    expect(page).to_not have_selector('#task-create-modal'), 'タスク追加モーダルが閉じられていません'
    expect(page).to have_content('JSを勉強する'), '新規追加したタスクが画面に表示されていません'
  end

  it 'タイトルを入力せず「追加」をクリックしたら新しいタスクが追加されず、モーダルも閉じない' do
    visit '/tasks'
    click_button('タスクを追加')
    sleep 0.5 # Bootstrapのモーダル対応
    click_on '追加'
    expect(page).to have_selector('#task-create-modal'), 'タスク追加モーダルが閉じてしまっています'
  end

  it 'タスク詳細のモーダルに「編集」ボタン、「削除」ボタンが表示されていること' do
    task = create(:task, title: 'JavaScriptのfor文を理解する', description: 'JavaScript本格入門の第二章に書かれているfor文を読んで理解する')
    visit '/tasks'
    find("#task-#{task.id}").click
    within "#task-detail-modal-#{task.id}" do
      expect(page).to have_button('編集'), 'タスク詳細モーダルに「編集」ボタンがありません'
      expect(page).to have_button('削除'), 'タスク詳細モーダルに「削除」ボタンがありません'
    end
  end

  it '「編集」ボタンを押すとモーダルが表示され、各フィールドの値を変更して「更新」ボタンを押すとその内容が反映される' do
    task = create(:task, title: 'JavaScriptのfor文を理解する', description: 'JavaScript本格入門の第二章に書かれているfor文を読んで理解する')
    visit '/tasks'
    find("#task-#{task.id}").click
    within "#task-detail-modal-#{task.id}" do
      click_on '編集'
    end
    sleep 0.5 # Bootstrapのモーダル対応
    expect(page).to_not have_selector("#task-detail-modal-#{task.id}"), 'タスク詳細モーダルが閉じられていません'
    within "#task-edit-modal-#{task.id}" do
      fill_in 'タイトル', with: 'JavaScriptのfor文とif文を理解する'
      fill_in '説明文', with: 'ES6とES5を完全に理解する'
      click_on '更新'
    end
    sleep 0.5 # Bootstrapのモーダル対応
    expect(page).to_not have_selector("#task-edit-modal-#{task.id}"), 'タスク編集モーダルが閉じられていません'
    expect(page).to have_content('JavaScriptのfor文とif文を理解する'), '更新後のタイトルがが一覧画面に表示されていません'
    find("#task-#{task.id}").click
    within "#task-detail-modal-#{task.id}" do
      expect(page).to have_content('JavaScriptのfor文とif文を理解する'), '更新後のタイトルがタスク詳細モーダルに表示されていません'
      expect(page).to have_content('ES6とES5を完全に理解する'), '更新後の説明文がタスク詳細モーダルに表示されていません'
    end
  end

  it '「削除」ボタンを押すとタスクが一覧画面から削除される' do
    task = create(:task, title: 'JavaScriptのfor文を理解する', description: 'JavaScript本格入門の第二章に書かれているfor文を読んで理解する')
    visit '/tasks'
    find("#task-#{task.id}").click
    within "#task-detail-modal-#{task.id}" do
      click_on '削除'
    end
    expect(page).to_not have_content('JavaScriptのfor文を理解する'), 'タスクが一覧画面から削除されていません'
  end

  it '「TODO」、「DOING」、「DONE」の3つのタスクリストが存在していること' do
    visit '/tasks'
    expect(page).to have_content('TODO'), '「TODO」の文言が表示されたタスクリストが存在しません'
    expect(page).to have_content('DOING'), '「DOINGの文言が表示されたタスクリストが存在しません'
    expect(page).to have_content('DONE'), '「DONE」の文言が表示されたタスクリストが存在しません'
  end

  it 'TODOステータスのタスクはTODOタスクリストに表示されること' do
    visit '/tasks'
    click_button('タスクを追加')
    fill_in 'タイトル', with: 'JSを勉強する'
    fill_in '説明文', with: 'ES6完全に理解する'
    select 'TODO', from: 'ステータス'
    click_on '追加'
    expect(page).to_not have_selector('#task-create-modal'), 'タスク追加モーダルが閉じられていません'
    within "#todo-list" do
      expect(page).to have_content('JSを勉強する'), '新規追加したタスクがTODOタスクリストに表示されていません'
    end
  end

  it 'DOINGステータスのタスクはDOINGタスクリストに表示されること' do
    visit '/tasks'
    click_button('タスクを追加')
    fill_in 'タイトル', with: 'JSを勉強する'
    fill_in '説明文', with: 'ES6完全に理解する'
    select 'DOING', from: 'ステータス'
    click_on '追加'
    expect(page).to_not have_selector('#task-create-modal'), 'タスク追加モーダルが閉じられていません'
    within "#doing-list" do
      expect(page).to have_content('JSを勉強する'), '新規追加したタスクがTODOタスクリストに表示されていません'
    end
  end

  it 'DONEステータスのタスクはDONEタスクリストに表示されること' do
    visit '/tasks'
    click_button('タスクを追加')
    fill_in 'タイトル', with: 'JSを勉強する'
    fill_in '説明文', with: 'ES6完全に理解する'
    select 'DONE', from: 'ステータス'
    click_on '追加'
    expect(page).to_not have_selector('#task-create-modal'), 'タスク追加モーダルが閉じられていません'
    within "#done-list" do
      expect(page).to have_content('JSを勉強する'), '新規追加したタスクがDONEタスクリストに表示されていません'
    end
  end

  it 'TODOのタスクをDONEに更新したらDONEタスクリストに移動すること' do
    task = create(:task, title: 'JavaScriptのfor文を理解する', description: 'JavaScript本格入門の第二章に書かれているfor文を読んで理解する', status: :todo)
    visit '/tasks'
    find("#task-#{task.id}").click
    within "#task-detail-modal-#{task.id}" do
      click_on '編集'
    end
    expect(page).to_not have_selector("#task-detail-modal-#{task.id}"), 'タスク詳細モーダルが閉じられていません'
    within "#task-edit-modal-#{task.id}" do
      fill_in 'タイトル', with: 'JavaScriptのfor文とif文を理解する'
      fill_in '説明文', with: 'ES6とES5を完全に理解する'
      select 'DONE', from: 'ステータス'
      click_on '更新'
    end
    expect(page).to_not have_selector("#task-edit-modal-#{task.id}"), 'タスク編集モーダルが閉じられていません'
    within "#done-list" do
      expect(page).to have_content('JavaScriptのfor文とif文を理解する'), 'DONEに更新したタスクがDONEタスクリストに表示されていません'
    end
  end
=end
  it 'ログイン状態でタイトルと説明文とステータスを入力して「追加」をクリックしたら新しいタスクが追加されている' do
    login_as(user)
    click_on('タスクを追加')
    fill_in 'タイトル', with: 'JSを勉強する'
    fill_in '説明文', with: 'ES6完全に理解する'
    select 'TODO', from: 'ステータス'
    click_on '追加'
    expect(page).to_not have_selector('#task-create-modal'), 'タスク追加モーダルが閉じられていません'
    expect(page).to have_content('JSを勉強する'), '新規追加したタスクが画面に表示されていません'
  end

  it '他人のタスク詳細モーダルには「編集」と「削除」ボタンが表示されない。' do
    others_task = create(:task, title: '他人のタスク', user: other_user)
    login_as(user)
    # 他人のタスク詳細モーダルを表示する
    find("#task-#{others_task.id}").click
    expect(page).to_not have_content('編集'), '他人のタスクに編集ボタンが表示されています'
    expect(page).to_not have_content('削除'), '他人のタスクに削除ボタンが表示されています'
  end

  it '自分のタスクには「編集」と「削除」ボタンが表示される' do
    my_task = create(:task, title: '自分のタスク', user: user)
    login_as(user)
    # 自分のタスク詳細モーダルを表示する
    find("#task-#{my_task.id}").click
    expect(page).to have_content('編集'), '自分のタスクに編集ボタンが表示されていません'
    expect(page).to have_content('削除'), '自分のタスクに削除ボタンが表示されていません'
  end

  it 'タスク追加フォームでバリデーションが機能していること' do
    login_as(user)
    click_on('タスクを追加')
    within "#task-create-modal" do
      fill_in 'タイトル', with: ''
      expect(page).to have_content('タイトルは必須項目です'), '必須チェックのバリデーションエラーが表示されていません'
      fill_in 'タイトル', with: 'a' * 51
      expect(page).to have_content('タイトルは50文字以下で入力してください'), '文字数チェックのバリデーションエラーが表示されていません'
      fill_in '説明文', with: 'a' * 501
      expect(page).to have_content('説明文は500文字以下で入力してください'), '文字数チェックのバリデーションエラーが表示されていません'
      click_on '追加'
      expect(page).to have_content('ステータスは必須項目です'), '必須チェックのバリデーションエラーが表示されていません'
    end
    expect(page).to have_selector("#task-create-modal"), 'バリデーションエラーが発生しているときに画面遷移してはいけません'
  end

  it 'タスク編集フォームでバリデーションが機能していること' do
    my_task = create(:task, title: '自分のタスク', user: user)
    login_as(user)
    find("#task-#{my_task.id}").click
    within "#task-detail-modal-#{my_task.id}" do
      click_on '編集'
    end

    within "#task-edit-modal-#{my_task.id}" do
      fill_in 'タイトル', with: ' '
      expect(page).to have_content('タイトルは必須項目です'), '必須チェックのバリデーションエラーが表示されていません'
      fill_in 'タイトル', with: 'a' * 51
      expect(page).to have_content('タイトルは50文字以下で入力してください'), '文字数チェックのバリデーションエラーが表示されていません'
      fill_in '説明文', with: 'a' * 501
      expect(page).to have_content('説明文は500文字以下で入力してください'), '文字数チェックのバリデーションエラーが表示されていません'
      click_on '更新'
    end

    expect(page).to have_selector("#task-edit-modal-#{my_task.id}"), 'バリデーションエラーが発生しているときに画面遷移してはいけません'
  end
end

