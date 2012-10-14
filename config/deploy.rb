require 'mina/git'
require 'mina/bundler'
require 'mina/rails'

set :user, 'root'
set :domain, '198.74.58.240'
set :deploy_to, '/data/guessingame'
set :identity_file, 'deploy'
set :repository, 'git@github.com:railsrumble/r12-team-502.git'

task :deploy do
  # FIXME: .bashrc should load it automatically
  queue "source '/usr/local/rvm/scripts/rvm'"

  deploy do
    # Preparations here
    invoke :'git:clone'
    invoke :'bundle:install'
    invoke :'rails:assets_precompile'
    invoke :migrate_public_files
    #invoke :migrate
    invoke :restart
  end
end

task :c do
  queue "source '/usr/local/rvm/scripts/rvm'"
  invoke :console
end

task :down do
  invoke :maintenance_on
  invoke :restart
end

task :maintenance_on do
  queue 'touch maintenance.txt'
end

task :restart do
  queue "mkdir -p #{deploy_to}/$build_path/tmp/ && touch #{deploy_to}/$build_path/tmp/restart.txt"
  #queue 'curl "http://mafia-team.r12.railsrumble.com/"'
end

task :logs do
  queue 'echo "Contents of the log file are as follows:"'
  queue "tail -f #{deploy_to}/current/log/production.log"
end

task :migrate do
  queue "cd #{deploy_to}/$build_path/ RAILS_ENV=production bundle exec rake db:drop && RAILS_ENV=production bundle exec rake db:create && RAILS_ENV=production bundle exec rake db:migrate && RAILS_ENV=production bundle exec rake db:seed"
end

task :migrate_public_files do
  queue "mkdir -p #{deploy_to}/current/public/uploads"
  queue "mv #{deploy_to}/current/public/uploads #{deploy_to}/$build_path/public/"
  queue "chmod -R 755 #{deploy_to}/$build_path/public/uploads"
end
