server '35.180.205.58', user: 'ubuntu', roles: %w{app db web}

append :linked_files, "config/database.yml", "config/secrets.yml", "config/master.key"

set :branch, 'main'
