# docker-rails-react-native-template
フロントreact-native サーバサイドrailsの雛形

## 構築手順
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
