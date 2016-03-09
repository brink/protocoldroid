# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.
# Don't declare `role :all`, it's a meta role
role :web, PRODUCTION_IPS.slice(:web18, :web19).values.collect{|host| "haikuls@" + host}
role :app, PRODUCTION_IPS.slice(:web18, :web19).values.collect{|host| "haikuls@" + host}

set :rails_env, 'production'
set :rack_env, 'production'
set :unicorn_env, 'production'
set :unicorn_rack_env, 'production'

# TODO: set symlink for data_path
set :data_path, '/glhaiku'
set :deploy_to, '/vhosts/apps/haiku-core'

set :keep_releases, 15
set :branch, 'master'

# This is the tmp dir where capistrano run git-ssh.sh script, by default it is "/tmp",
# however some server does not allow executing script from "/tmp"
set :tmp_dir, "/home/haikuls/tmp"

role :sidekiq, PRODUCTION_IPS.slice(:web18, :web19).values
set :sidekiq_processes, 4
set :sidekiq_options_per_process, [
      "-e production --config config/sidekiq_indexing.yml --tag indexing",
      "-e production --config config/sidekiq_import_validator.yml --tag import_validator",
      "-e production --config config/sidekiq_small_import.yml --tag small_import",
      "-e production --config config/sidekiq_large_import.yml --tag large_import"
    ]
