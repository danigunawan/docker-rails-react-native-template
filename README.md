# docker-rails-react-native-template
フロントreact-native サーバサイドrailsの雛形

## rails サーバ構築手順
```
gem --version
2.5.2.3

brew --version
1.8.3
```
syncの準備
```
gem install docker-sync
brew install fswatch
brew install unison
```

Dockerfile, docker-compose.yml, docker-compose-dev.yml, docker-sync.ymlを用意する

他コンテナとmysqlを共有するためnetwork作る
```
docker network create --driver bridge common_link
```
ビルドする
```
docker-compose build
docker-sync start
docker-compose -f docker-compose.yml -f docker-compose-dev.yml up
```
別windowでコンテナに入る
```
docker-compose exec app /bin/bash -l
```
appコンテナ上で
Gemfile Gemfile.lock作る
```
bundle init
touch Gemfile.lock
```

Gemfileのrailsの記述だけ変更するバージョンは5.1.6
```
# frozen_string_literal: true
source "https://rubygems.org"

gem 'rails', '~> 5.1.6'
gem 'i18n', '~> 1.0.0'
```
i18nのバージョン指定しないとエラー出る

コンテナ上で
```
bundle install --path vendor/bundler
bundle exec rails new . --force --database=mysql --skip-bundle --skip-test
```
これでappができる
config/database.ymlを設定する

```
docker-compose exec mysql /bin/bash -l
```
で入り
```
mysql -u root -p 
devpass
```
で入れればオッケー

# react-nativeビルド手順
yarn1.7
node 11
watchman 4.9.0
https://qiita.com/Umibows/items/175a066c1259ff4b0158

一旦グローバルインストールしてreact-native initする
終わったら
```
yarn global remove react-native-cli
```
package.jsonを以下のように編集
nameはアプリの名前に揃える
必須ではないがほぼほぼ使うものは最初から入れる
react-nativeのバージョンは0.57
warningを出さないようにしといた

```
{
  "name": "myspace",
  "version": "0.0.1",
  "private": true,
  "scripts": {
    "start": "react-native run-ios --simulator='iPhone 7'",
    "android": "react-native run-android",
    "test": "jest",
    "lint": "eslint index.js src"
 },
  "dependencies": {
    "formik": "^1.3.2",
    "native-base": "^2.8.1",
    "react": "16.6.3",
    "react-native": "^0.57.0",
    "react-native-vector-icons": "^6.1.0",
    "react-navigation": "^2.18.2",
    "prop-types": "^15.0.0",
    "react-redux": "^6.0.0",
    "redux": "^4.0.1",
    "redux-logger": "^3.0.6",
    "redux-thunk": "^2.3.0",
    "superagent": "^3.8.3",
    "yup": "^0.26.6"
  },
  "devDependencies": {
    "babel-eslint": "^10.0.1",
    "babel-jest": "23.6.0",
    "@babel/core": "7.0.0",
    "babel-core": "^6.0.0",
    "metro-react-native-babel-preset": "^0.45.0",
    "eslint": "4.19.1",
    "eslint-config-airbnb": "^17.1.0",
    "eslint-plugin-import": "^2.14.0",
    "eslint-plugin-jsx-a11y": "^6.1.2",
    "eslint-plugin-react": "^7.11.1",
    "jest": "23.6.0",
    "react-test-renderer": "16.3.1"
  },
  "jest": {
    "preset": "react-native"
  }
}
```

```
yarn install
yarn start
```
でビルドできる。