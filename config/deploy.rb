require "bundler/capistrano" 
ssh_options[:forward_agent] = true
default_run_options[:pty] = true
set :application, "sportdemo"
set :repository,  "sportdemo"
set :scm, :git
set :scm_username, "railsfans"   # 资源库的用户名
set :scm_password, Proc.new {Capistrano::CLI.password_prompt 'svn password: '}   # 资源库的密码
set :repository, "git@github.com:railsfans/sportdemo.git"
set :user, "root"
set :password, Proc.new {Capistrano::CLI.password_prompt 'centos server password: '} 
set :use_sudo, false
# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :deploy_to,        "/opt/#{application}"
set :deploy_via, :remote_cache

role :web, "192.168.1.240"                          # Your HTTP server, Apache/etc
role :app, "192.168.1.240"                          # This may be the same as your `Web` server
role :db,  "192.168.1.240", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"
set :shared_children, shared_children + %w{public/phoneapp}
after "deploy:update_code", "deploy:symlink_shared"
namespace :deploy do
  task :copy_config_files, :roles => [:app] do
    db_config = "#{shared_path}/database.yml"
    run "cp #{db_config} #{release_path}/config/database.yml"
  end
  task :update_symlink do
    run "ln -s #{shared_path}/public/system #{current_path}/public/system"
  end
  
   task :dev_migrate do
     run "cd /opt/sportdemo/current; bundle exec rake db:migrate RAILS_ENV=production"
   end
   
   task :restart do 
     run "/opt/nginx/sbin/nginx -s reload"
   end
   task :start do 
     run "/opt/nginx/sbin/nginx"
   end
   task :stop do 
     run  "/opt/nginx/sbin/nginx -s stop"
   end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#      run  "/opt/nginx/sbin/nginx -s restart"
   end
	desc "Symlink shared configs and folders on each release."
      task :symlink_shared do
        run "ln -nfs #{shared_path}/phoneapp #{release_path}/public/phoneapp"
      end
 end
# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end


