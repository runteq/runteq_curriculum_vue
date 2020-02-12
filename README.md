# 学習カリキュラム（Vue.js編）

こちらは学習カリキュラム（Vue.js編）のリポジトリです。

## カリキュラム説明

本カリキュラムでタスク管理アプリを作ってもらいます。

Railsで作成されたAPIをフロントのVue.jsから呼び出すようなSPA構成のアプリケーション開発の基礎を学ぶことができます。


## Features

### フロントエンド

- Vue.js 2.6.11
- Webpacker
- yarn

### CSSフレームワーク

- Bootstrap4

### その他

- See `Gemfile`.

## Ruby version

- See `.ruby-version`.

## Rails version

- See `Gemfile`.


## Project initiation

- リポジトリのクローン

```bash
$ git clone {各自に振られたGitリポジトリ}
```

- Gemのインストール

```bash
$ bundle install --path vendor/bundle
```

- npmのインストール

```bash
$ yarn install
```

## Run rails + webpack dev server

```bash
$ bundle exec foreman start
```

## Run rubocop（auto correct）

```bash
$ bundle exec rubocop -a
```

