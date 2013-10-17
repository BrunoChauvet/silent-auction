require 'bundler/deployment'

application = 'silent-auction'

set :application, "#{application}"
set :stages, %w(production)
set :default_stage, "production"

set :user, "user"
set :scm, "git"
set :repository, "git@github.com:BrunoChauvet/#{application}.git"
set :branch, "master"

set :deploy_to, "/var/www/#{application}"

set :repository_cache, "git_cache"
set :deploy_via, :remote_cache
set :use_sudo, false

set :ssh_options, { :forward_agent => true }

after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup'

end