# Change to match your CPU core count
workers 2

# Min and Max threads per worker
threads 1, 6

app_dir = File.expand_path("../", __FILE__)
shared_dir = "#{app_dir}/shared"

# Default to production
rails_env = ENV['RAILS_ENV'] || "production"
environment rails_env

# Set up socket location
#bind "unix://#{shared_dir}/sockets/puma.sock"
bind "unix:///home/webuser/linkdot_api/shared/sockets/puma.sock"

# Logging
stdout_redirect "/home/webuser/linkdot_api/shared/log/puma.stdout.log", "/home/webuser/linkdot_api/shared/log/puma.stderr.log", true

# Set master PID and state locations
pidfile "/home/webuser/linkdot_api/shared/pids/puma.pid"
state_path "/home/webuser/linkdot_api/shared/pids/puma.state"
activate_control_app

on_worker_boot do
  require "active_record"
  ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
  ActiveRecord::Base.establish_connection(YAML.load_file("/home/webuser/linkdot_api/config/database.yml")[rails_env])
end

#sudo -u nginx test -w /home/webuser/linkdot_api/config/shared/sockets/puma.sock && echo True
