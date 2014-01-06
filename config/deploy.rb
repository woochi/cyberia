set :application, 'cyberia'
set :repo_url, 'git@github.com:woochi/cyberia.git'

# Grunt detup
set :grunt_tasks, 'deploy'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, '/home/deploy/apps/cyberia'
set :scm, :git

# set :format, :pretty
set :log_level, :debug
# set :pty, true

# set :linked_files, %w{config/database.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 2

# Node options
set :node_binary, "/usr/bin/coffee"
set :app_command, "app.coffee"
set :upstart_job_name, "cyberia"

set :bundle_flags, ''
#set :rvm_ruby_version, '2.0.0-p353'
#set :default_env, { rvm_bin_path: '~/.rvm/bin' }
#SSHKit.config.command_map[:rake] = "#{fetch(:default_env)[:rvm_bin_path]}/rvm ruby-#{fetch(:rvm_ruby_version)} do bundle exec rake"

before "deploy", "deploy:create_release_dir"
before "deploy", "node:create_upstart_config"
before "deploy:updated", "node:install_packages"
after "deploy:updated", "node:restart"
after "deploy:rollback", "node:restart"

namespace :deploy do

  before :updated, 'grunt'

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  task :create_release_dir do#, :except => {:no_release => true} do
    on roles(:app) do
      execute :mkdir, '-p', releases_path
      ["logs", "pids"].each {|dir| execute :mkdir, "-p", shared_path.join(dir)}
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
