require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/scm/git'
install_plugin Capistrano::SCM::Git

require 'capistrano/bundler'
require 'capistrano/rails'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
require 'capistrano/puma'
require 'capistrano/puma/workers'
require 'capistrano/puma/nginx'

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
