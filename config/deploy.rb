# config/deploy.rb

# Application name and repository URL
set :application, 'bluelry_api'
set :repo_url, 'git@github.com:ayoub-sourrakh/bluelry_api.git'

# Deploy to the user's home directory
set :deploy_to, "/home/ubuntu/apps/#{fetch(:application)}"

# Use :linked_files and :linked_dirs settings to keep important files across deployments
append :linked_files, 'config/database.yml', 'config/master.key', 'config/secrets.yml'
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

# Ensure we're using the right version of Ruby (adjust as needed)
set :rbenv_ruby, '3.1.2'

# Number of releases to keep on the server
set :keep_releases, 5

set :branch, 'main'

# Include tasks from other gems included in your Gemfile
require 'capistrano/bundler'
require 'capistrano/rails'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
require 'capistrano/puma'
require 'capistrano/puma/workers'
require 'capistrano/puma/nginx'

# Puma settings
set :puma_threads, [4, 16]
set :puma_workers, 0

# Don't change these unless you know what you're doing
set :pty, true
set :use_sudo, false
set :stage, :production
set :deploy_via, :remote_cache
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.access.log"
set :puma_error_log, "#{release_path}/log/puma.error.log"
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do
  desc 'Restart application'
  task :restart do
    invoke 'puma:restart'
  end

  after :finishing, 'deploy:cleanup'
  after 'deploy:publishing', 'deploy:restart'
end
