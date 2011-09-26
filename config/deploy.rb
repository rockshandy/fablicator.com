require 'bundler/capistrano'

default_run_options[:pty] = false
ssh_options[:forward_agent] = true
set :use_sudo, false
set :user, "landru13"

set :application, "fablicator.com"
set :repository,  "git@github.com:rockshandy/fablicator.com.git"

set :scm, :git
set :branch, 'master'
set :git_shallow_clone, 1
set :deploy_via, :copy
set :copy_cache, true
set :rails_env, 'production'
#set :scm_command, "~/packages/bin/git" #updated version of git on server in user directory
#set :local_scm_command, "/usr/bin/git" #correct path to local git

set :rails_env, :production
set :deploy_to, "/home/#{user}/#{application}"

role :web, "#{application}"                          # Your HTTP server, Apache/etc
role :app, "#{application}"                          # This may be the same as your `Web` server
role :db,  "#{application}", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

desc "Restarting after deployment"
task :after_deploy, :roles => [:app, :db, :web] do
 run "sed 's/# ENV\\[/ENV\\[/g' #{deploy_to}/current/config/environment.rb > #{deploy_to}/current/config/environment.temp"
 run "mv #{deploy_to}/current/config/environment.temp #{deploy_to}/current/config/environment.rb"
end

