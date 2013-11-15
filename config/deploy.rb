require 'bundler/deployment'

# Not working with Capistrano 3.0
# require 'puma/capistrano'

application = 'silent-auction'

set :application, "#{application}"
set :stages, %w(production, staging)
set :default_stage, "staging"

set :user, "deployer"

set :scm, :git
set :repo_url, "git@github.com:BrunoChauvet/#{application}.git"
set :branch, "master"
set :repository_cache, "git_cache"
set :deploy_via, :remote_cache
set :use_sudo, false

set :deploy_to, "/var/www/#{application}"
set :ssh_options, { forward_agent: true }

set :rvm_type, :auto
set :rvm_ruby_version, '2.0.0'

after "deploy", "deploy:cleanup", "deploy:stop", "deploy:start"

server_path = "/var/www/silent-auction/current"
user        = "deployer"

puma_sock    = "unix://#{shared_path}/sockets/puma.sock"
puma_control = "unix://#{shared_path}/sockets/pumactl.sock"
puma_state   = "#{shared_path}/sockets/puma.state"

puma_log     = "#{server_path}/log/puma.log"
puma_pid     = "#{server_path}/tmp/puma.pid"

namespace :deploy do
  desc "Start the application"
  task :start do
    # nothing for passenger
  end

  task :stop do
    # nothing for passenger
  end
 
  desc "Restart the application"
  task :restart do
    puts "Restarting passenger from capistrano"
    on "#{user}@localhost" do |host|
      within "#{server_path}" do
        test :mkdir, :tmp
      end

      within "#{server_path}/tmp" do
        test :touch, "restart.txt"
      end
    end
  end

end
