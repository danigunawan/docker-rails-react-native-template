#!/bin/bash
bundle install --path vendor/bundler
bin/rails db:create
bin/rails db:migrate