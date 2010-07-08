set :user, "guy"
set :domain, "weblitz.me.uk"
set :application, "cv"
set :repository,  "git@github.com:gwhn/clean_cv.git"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :deploy_to, "/home/#{user}/#{application}"

role :web, domain                          # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run

set :deploy_via, :remote_cache
set :branch, 'master'
set :scm_verbose, true
set :use_sudo, false

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

#after "deploy:update_code", :configure_database
#desc "copy database.yml into the current release path"
#task :configure_database, :roles => :app do
#  db_config = "#{deploy_to}/config/database.yml"
#  run "cp #{db_config} #{release_path}/config/database.yml"
#end