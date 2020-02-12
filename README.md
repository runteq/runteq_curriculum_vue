# 学習カリキュラム Vue.js

こちらはRUNTEQのVue.js学習カリキュラムです。

本カリキュラムでタスク管理アプリを作ってもらいます。

Railsで作成されたAPIをフロントのVue.jsから呼び出すようなSPA構成のアプリケーション開発の基礎を学ぶことができます。

## Ruby version

* 2.6.5

## Rails version

* 6.0.2.1

## System dependencies

* MySQL 5.7
* Node.js >= v12.14.0
* Yarn >= 1.19.2

## Vue.js version

- Vue.js 2.6.11

## Project initiation

* Gemのインストール

```
$ bundle install --path=vendor/bundle
```

* npmのインストール

```
$ yarn install
```

## Configuration

ファイルの中身はご自身の環境に合わせて適宜変更してください

* データベースの設定

```
$ cp config/database.yml.default config/database.yml
```

## Database creation

```
$ bundle exec rails db:reset
```

## Run rails server

```
$ bundle exec rails server
```

## Run rails + webpack dev server

```bash
$ bundle exec foreman start
```

## Run rubocop（auto correct）

```bash
$ bundle exec rubocop -a
```
