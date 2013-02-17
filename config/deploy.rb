#========================
#CONFIG
#========================
set :application, "slidown"
default_run_options[:pty] = true 
set :scm, :git
set :git_enable_submodules, 1
set :repository, "git@github.com:secreek/slidown.git"
set :branch, "master"
set :ssh_options, { :forward_agent => true }
 
set :stage, :production
set :user, "slidown"
set :use_sudo, true 
set :runner, "deploy"
set :deploy_to, "/home/#{application}"
#set :deploy_to, "/var/www/#{application}"
set :app_server, :thin
set :domain, "slidown.com"
 
#========================
#ROLES
#========================
role :app, domain
role :web, domain
role :db, domain, :primary => true

#========================
#CUSTOM
#========================
 
namespace :deploy do
   # task :start, :roles => :app do
   #  run "touch #{delpoy_to}/tmp/restart.txt"
   # end
 
  # task :stop, :roles => :app do
  #   # Do nothing.
  # end
 
  desc "Restart Application"
  task :restart, :roles => :app do
    run "ln -s /home/slidown/shared/file_repo /home/slidown/current/src/file_repo"
    run "/home/slidown/slidown.sh restart"
  end
end
