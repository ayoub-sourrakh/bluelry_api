# config/deploy.rb
set :application, 'bluelry_api'
set :repo_url, 'git@github.com:ayoub-sourrakh/bluelry_api.git'
set :deploy_to, "/home/ubuntu/apps/#{fetch(:application)}"

append :linked_files, 'config/database.yml', 'config/master.key', 'config/secrets.yml'
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

set :rbenv_ruby, '3.1.2'
set :keep_releases, 5
set :branch, 'main'

set :default_env, { path: "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH" }
set :rails_env, 'production'

# Puma configuration
set :puma_threads, [4, 16]
set :puma_workers, 0
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

  before 'deploy:starting', 'puma:make_dirs'
end

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:stop'
      invoke 'puma:start'
    end
  end

  after :finishing, 'deploy:cleanup'
  # after 'deploy:publishing', 'deploy:restart'
end
