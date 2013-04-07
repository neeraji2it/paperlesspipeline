set :default_stage, "staging"
require 'capistrano/ext/multistage'
require 'bundler/capistrano'
require 'rvm/capistrano'

set :application, "paperlesspipeline"
set :repository,  "git@github.com:neeraji2it/paperlesspipeline.git"
set :scm, :git
set :scm_user, "rails"

desc "Symlinks database.yml, mailer.yml file from shared directory into the latest release"
task :symlink_shared, :roles => [:app, :db] do
  run "ln -s #{shared_path}/config/database.yml #{latest_release}/config/database.yml"
  run "ln -s #{shared_path}/db/sphinx #{latest_release}/db/sphinx"
  run "ln -s #{shared_path}/system #{latest_release}/system"
end

after 'deploy:finalize_update', :symlink_shared

namespace :deploy do
  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
end
