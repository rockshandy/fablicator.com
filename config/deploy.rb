require 'bundler/capistrano'
load 'deploy/assets'

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

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

desc "After updating code we need to populate a new database.yml"
task :after_update_code, :roles => :app do
  require "yaml"
  set :production_database_password, proc { Capistrano::CLI.password_prompt("Production database remote Password : ") }

  buffer = YAML::load_file('config/database.yml.example')
  # get ride of uneeded configurations
  buffer.delete('test')
  buffer.delete('development')

  # Populate production element
  buffer['production']['adapter'] = "mysql2"
  buffer['production']['database'] = "fablicator_production"
  buffer['production']['username'] = user
  buffer['production']['password'] = production_database_password
  buffer['production']['host'] = "mysql.fablicator.com"

  put YAML::dump(buffer), "#{release_path}/config/database.yml", :mode => 0664

  # setup auts for login simply copy auths.yml
  # should already be made from auths.yml.example
  #buffer = YAML::load_file('config/auths.yml')
  #buffer.delete('test')
  #buffer.delete('development')
  #put YAML::dump(buffer), "#{release_path}/config/auths.yml", :mode => 0664
end

desc "Restarting after deployment"
task :after_deploy, :roles => [:app, :db, :web] do
 run "sed 's/# ENV\\[/ENV\\[/g' #{deploy_to}/current/config/environment.rb > #{deploy_to}/current/config/environment.temp"
 run "mv #{deploy_to}/current/config/environment.temp #{deploy_to}/current/config/environment.rb"
end
