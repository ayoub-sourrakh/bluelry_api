# config/deploy.rb

# Application name and repository URL
set :application, 'bluelry_api'
set :repo_url, 'git@github.com:ayoub-sourrakh/bluelry_api.git'

# Deploy to the user's home directory
set :deploy_to, "/home/ubuntu/apps/#{fetch(:application)}"

# Use :linked_files and :linked_dirs settings to keep important files across deployments
append :linked_files, 'config/database.yml', 'config/master.key'
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

# Ensure we're using the right version of Ruby (adjust as needed)
set :rbenv_ruby, '3.1.2'

# Number of releases to keep on the server
set :keep_releases, 5

append :linked_files, "config/database.yml", "config/secrets.yml", "config/master.key"

set :branch, 'main'
