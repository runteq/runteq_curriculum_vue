#!/bin/sh
set -e

bin/rails db:migrate

rm -f tmp/pids/server.pid && bundle exec foreman start
