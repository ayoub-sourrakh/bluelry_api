max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

worker_timeout 3600 if ENV.fetch("RAILS_ENV", "development") == "development"

port        ENV.fetch("PORT") { 3000 }
environment ENV.fetch("RAILS_ENV") { "production" }

pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }
state_path ENV.fetch("STATE_PATH") { "tmp/pids/puma.state" }
bind "unix:///home/ubuntu/apps/bluelry_api/shared/tmp/sockets/puma.sock" if ENV.fetch("RAILS_ENV") == "production"

workers ENV.fetch("WEB_CONCURRENCY") { 2 } if ENV.fetch("RAILS_ENV") == "production"
preload_app! if ENV.fetch("RAILS_ENV") == "production"

plugin :tmp_restart
