# Load DSL and set up stages
require 'capistrano/setup'

# Include default deployment tasks
require 'capistrano/deploy'

# Include additional tasks
require 'capistrano/rbenv'
require 'capistrano/bundler'
require 'capistrano/rails/migrations'
require 'capistrano/puma'
install_plugin Capistrano::Puma
install_plugin Capistrano::Puma::Systemd
require 'capistrano/puma/workers'
require 'capistrano/puma/nginx'

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
