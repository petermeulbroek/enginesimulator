#!/bin/bash -xv
export RAILS_ENV=production
export PATH=~rbenv/.rbenv/shims:$PATH
bundle exec puma -C config/puma.rb 
