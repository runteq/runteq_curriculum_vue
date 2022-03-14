# 学習カリキュラム Vue.js

こちらはRUNTEQのVue.js学習カリキュラムです。

本カリキュラムでタスク管理アプリを作ってもらいます。

Railsで作成されたAPIをフロントのVue.jsから呼び出すようなSPA構成のアプリケーション開発の基礎を学ぶことができます。

## 使用バージョン

- Ruby 2.6.5
- Rails 6.0.2.1
- Vue.js 2.6.11
- Node.js v15.14.0
- Yarn 1.19.2 以降

## プロジェクトのセットアップ手順

ターミナルでgit cloneして作成されたフォルダに移動して、下記のコマンドを実行してください

- このプロジェクトで使用するライブラリをインストール
```bash
$ bundle config --local path 'vendor/bundle'
$ bundle config --local build.sassc -- --disable-march-tune-native
$ bundle install
$ yarn install
```

- データベースの設定を雛形のdefaultファイルをコピーして作成

```bash
$ cp config/database.yml.default config/database.yml
```

- データベースおよびテーブルの作成

```bash
$ bundle exec rails db:setup
```

- バックエンド側サーバーの起動

```bash
$ bundle exec rails server
```

- フロントエンド側サーバーの起動
```bash
$ bin/webpack-dev-server
```

- 以上のコマンドが正しく実行できた場合、ブラウザで`localhost:3000`にアクセスしましょう。

また、`foreman`でもサーバーを起動できるようにしています。
 
```bash
$ bundle exec foreman start
```

- config/master.keyの配置
`touch config/master.key`でファイルを作成して`e3c0406397e8f960e7e165206d57b579`を値として追記、保存してください。  
※ エディタの設定で行末に自動的に改行が挿入されてしまうこともあるので注意してください。   

※ 現場の開発フローでは`master.key`の値をGit管理しているREADMEなどのファイルに直に記載することはないので、他の開発者から共有してもらいローカルでファイルを作成します。  
