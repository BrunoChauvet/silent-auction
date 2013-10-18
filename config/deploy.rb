require 'bundler/deployment'

# Not working with Capistrano 3.0
# require 'puma/capistrano'

application = 'silent-auction'

set :application, "#{application}"
set :stages, %w(production, development)
set :default_stage, "development"

set :user, "user"

set :scm, :git
set :repo_url, "git@github.com:BrunoChauvet/#{application}.git"
set :branch, "master"
set :repository_cache, "git_cache"
set :deploy_via, :remote_cache
set :use_sudo, false

set :deploy_to, "/var/www/#{application}"
set :ssh_options, { forward_agent: true }

after "deploy", "deploy:cleanup", "deploy:stop", "deploy:start"

server_path = "/var/www/silent-auction/current"

puma_sock    = "unix://#{shared_path}/sockets/puma.sock"
puma_control = "unix://#{shared_path}/sockets/pumactl.sock"
puma_state   = "#{shared_path}/sockets/puma.state"

puma_log     = "#{server_path}/log/puma.log"
puma_pid     = "#{server_path}/tmp/puma.pid"

namespace :deploy do
  desc "Start the application"
  task :start do
    puts "Starting puma"
    `cd #{server_path} && bundle exec puma --pidfile #{puma_pid} -S #{puma_state} --threads 16:32 --workers 16 >> #{puma_log} &`
  end
 
  desc "Stop the application"
  task :stop do
    puts "Stoping puma"
    `cd #{server_path} && bundle exec pumactl -S #{puma_state} stop`
  end
 
  desc "Restart the application"
  task :restart do
    puts "Restarting puma from capistrano"
    on "user@localhost" do |host|
      within "#{server_path}" do
        execute :mkdir, "tmp"
        execute(:rails, "server -p 9292 --daemon")
        # test(:puma, "--pidfile #{puma_pid} -S #{puma_state} --threads 16:32 --workers 16 >> #{puma_log} -d")
        # execute "bundle exec pumactl -S #{puma_state} stop"
        # background "bundle exec puma --pidfile #{puma_pid} -S #{puma_state} --threads 16:32 --workers 16 >> #{puma_log}"
      end
    end
  end
 
  desc "Status of the application"
  task :status do
    `cd #{server_path} && bundle exec pumactl -S #{puma_state} stats`
  end
end
