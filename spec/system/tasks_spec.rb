require 'rails_helper'
RSpec.describe 'タスク管理', type: :system do
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
  it '未ログイン状態でヘッダーに「ユーザー登録」、「ログイン」ボタンが表示されている' do
    visit root_path
    expect(page).to have_content('ユーザー登録'), '未ログイン状態でヘッダーに「ユーザー登録」ボタンが表示されていません'
    expect(page).to have_content('ログイン'), '未ログイン状態でヘッダーに「ログイン」ボタンが表示されていません'
  end

  it 'ユーザー登録ページで各フィールドを入力して「登録」をクリックしたらユーザーが登録されている' do
    visit root_path
    click_link 'ユーザー登録'
    fill_in 'ユーザー名', with: 'test'
    fill_in 'メールアドレス', with: 'test@example.com'
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード（確認）', with: 'password'
    click_button '登録'
    sleep 0.5
    expect(current_path).to eq('/login'), 'ログインページに遷移できていません'
  end

  it '登録済みユーザーでログインできる' do
    visit root_path
    click_link 'ユーザー登録'
    fill_in 'ユーザー名', with: 'test'
    fill_in 'メールアドレス', with: 'test@example.com'
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード（確認）', with: 'password'
    click_button '登録'
    sleep 0.5
    expect(current_path).to eq('/login'), 'ログインページに遷移できていません'
    fill_in 'メールアドレス', with: 'test@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
    sleep 0.5
    expect(current_path).to eq('/tasks'), 'タスクページに遷移できていません'
  end

  it 'ログイン状態でログアウトできる' do
    visit root_path
    click_link 'ユーザー登録'
    fill_in 'ユーザー名', with: 'test'
    fill_in 'メールアドレス', with: 'test@example.com'
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード（確認）', with: 'password'
    click_button '登録'
    sleep 0.5
    expect(current_path).to eq('/login'), 'ログインページに遷移できていません'
    fill_in 'メールアドレス', with: 'test@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
    sleep 0.5
    expect(current_path).to eq('/tasks'), 'タスクページに遷移できていません'
    expect(page).to have_content('ログアウト'), 'ログイン状態でヘッダーに「ログアウト」ボタンが表示されていません'
    click_link 'ログアウト'
    sleep 0.5
    expect(current_path).to eq('/'), 'トップページに遷移できていません'
  end

  it '未ログイン状態でタスクページに遷移したら、ログインページにリダイレクトされる' do
    visit root_path
    click_link 'はじめる'
    expect(current_path).to eq('/login'), 'ログインページに遷移できていません'
  end

  it 'ログイン状態でタスクページに遷移したら、タスクページが表示される' do
    visit root_path
    click_link 'ユーザー登録'
    fill_in 'ユーザー名', with: 'test'
    fill_in 'メールアドレス', with: 'test@example.com'
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード（確認）', with: 'password'
    click_button '登録'
    sleep 0.5
    expect(current_path).to eq('/login'), 'ログインページに遷移できていません'
    fill_in 'メールアドレス', with: 'test@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
    sleep 0.5
    click_link '戻る'
    expect(current_path).to eq('/'), 'トップページに遷移できていません'
    click_link 'はじめる'
    expect(current_path).to eq('/tasks'), 'タスクページに遷移できていません'
  end

  it 'ログイン状態でタイトルと説明文とステータスを入力して「追加」をクリックしたら新しいタスクが追加されている' do
    visit root_path
    click_link 'ユーザー登録'
    fill_in 'ユーザー名', with: 'test'
    fill_in 'メールアドレス', with: 'test@example.com'
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード（確認）', with: 'password'
    click_button '登録'
    sleep 0.5
    expect(current_path).to eq('/login'), 'ログインページに遷移できていません'
    fill_in 'メールアドレス', with: 'test@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
    sleep 0.5
    expect(current_path).to eq('/tasks'), 'タスクページに遷移できていません'
    click_button('タスクを追加')
    fill_in 'タイトル', with: 'JSを勉強する'
    fill_in '説明文', with: 'ES6完全に理解する'
    select 'TODO', from: 'ステータス'
    click_on '追加'
    expect(page).to_not have_selector('#task-create-modal'), 'タスク追加モーダルが閉じられていません'
    expect(page).to have_content('JSを勉強する'), '新規追加したタスクが画面に表示されていません'
  end

  it '他人のタスク詳細モーダルには「編集」と「削除」ボタンが表示されない。自分のタスクには表示される' do
    # 他人のタスクを作る
    visit 'register'
    fill_in 'ユーザー名', with: 'others'
    fill_in 'メールアドレス', with: 'others@example.com'
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード（確認）', with: 'password'
    click_button '登録'
    fill_in 'メールアドレス', with: 'others@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
    click_button('タスクを追加')
    fill_in 'タイトル', with: '他人のタスク'
    select 'TODO', from: 'ステータス'
    click_on '追加'
    expect(page).to have_content('他人のタスク'), '新規追加したタスクが画面に表示されていません'
    click_link 'ログアウト'
    # 自分のタスクを作る
    click_link 'ユーザー登録'
    fill_in 'ユーザー名', with: 'myself'
    fill_in 'メールアドレス', with: 'myself@example.com'
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード（確認）', with: 'password'
    click_button '登録'
    fill_in 'メールアドレス', with: 'myself@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
    click_button('タスクを追加')
    fill_in 'タイトル', with: '自分のタスク'
    select 'TODO', from: 'ステータス'
    click_on '追加'
    expect(page).to have_content('自分のタスク'), '新規追加したタスクが画面に表示されていません'
    # 他人のタスク詳細モーダルを表示する
    others_link = find('span', text: '他人のタスク')
    others_link.click
    sleep 0.5
    expect(page).to_not have_content('編集'), '他人のタスクに編集ボタンが表示されています'
    expect(page).to_not have_content('削除'), '他人のタスクに削除ボタンが表示されています'
    click_on '閉じる'
    # 自分のタスク詳細モーダルを表示する
    others_link = find('span', text: '自分のタスク')
    others_link.click
    sleep 0.5
    expect(page).to have_content('編集'), '自分のタスクに編集ボタンが表示されていません'
    expect(page).to have_content('削除'), '自分のタスクに削除ボタンが表示されていません'
    click_on '閉じる'
  end
end

