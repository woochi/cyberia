require "capistrano/node-deploy"

set :application, "cyberia"
set :repository,  "git@github.com:woochi/cyberia.git"
set :user, "deploy"
set :scm, :git
set :deploy_to, "/home/deploy/apps"

set :app_environment, "PORT=8003"
set :node_binary, "/usr/bin/coffee"
set :app_command, "app.coffee"
set :upstart_job_name, "cyberia"

role :app, "cyberia2020.com"
