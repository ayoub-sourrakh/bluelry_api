server '35.180.205.58', user: 'ubuntu', roles: %w{app db web}

append :linked_files, "config/database.yml", "config/secrets.yml", "config/master.key"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

set :branch, 'main'

set :ssh_options, {
  forward_agent: true,
  auth_methods: %w(publickey),
  keys: %w(~/.ssh/your_key.pem)
}
