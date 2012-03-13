require 'bundler/capistrano'
#load 'deploy/assets'

default_run_options[:pty] = false
ssh_options[:forward_agent] = true
set :use_sudo, false
set :user, ENV['fab_user']
set :keep_releases, 3

set :application, "fablicator.com"
set :repository,  "git@github.com:rockshandy/fablicator.com.git"

set :scm, :git
# sends off current git branch
set :branch, $1 if `git branch` =~ /\* (\S+)\s/m
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

# OPTIMIZE: can probably make the below things tasks and switch after syntax
#           also the very bottom :after_ user is deprecated should fix that
namespace :deploy do
  after "deploy:finalize_update" do
    %w(database.yml auths.yml).each do |yml|
      run "cp /home/#{user}/#{yml}   #{release_path}/config/#{yml}"
    end
    puts "Ran update database_yml and auth_yml"
  end
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
