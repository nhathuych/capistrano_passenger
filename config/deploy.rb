# config valid for current version and patch releases of Capistrano
lock '~> 3.17.2'

set :application, 'rails_seven_exploring'
set :repo_url, "git@github.com:nhathuych/rails_seven_exploring.git"
set :ssh_options, { :forward_agent => true }

ask :branch, nil || proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# chỉ định cho Bundler rằng không tải xuống các phiên bản của các gem phụ thuộc trong Gemfile.lock.
# Thay vào đó, Bundler sử dụng các phiên bản gem được cài đặt trên máy tính đang chạy để thực hiện các thao tác cài đặt và cập nhật.
set :bundle_flags, '--no-deployment'

set :pty, true

# Thư mục shared chứa các linked_files và linked_dirs.
# Các file chứa các thông tin nhạy cảm như application.yml, database.yml, secret.yml sẽ không được đưa lên Github
append :linked_files, 'config/database.yml', 'config/credentials/production.key'

# Các file này sẽ được dùng chung cho tất cả các lần deploy và sẽ được link đến các file tương ứng trong quá trình deploy
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', '.bundle', 'public/system', 'public/uploads'

set :keep_releases, 5
set :rvm_type, :user

set :passenger_roles, :app
set :passenger_restart_runner, :sequence
set :passenger_restart_wait, 5
set :passenger_restart_limit, 2
set :passenger_restart_with_sudo, false
set :passenger_environment_variables, {}
set :passenger_restart_with_touch, true
set :passenger_restart_command, 'passenger-config restart-app'  # tự động restart mà ko cần tạo file rake task
set :passenger_restart_options, -> { "#{deploy_to} --ignore-app-not-running" }

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", 'config/master.key'

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "tmp/webpacker", "public/system", "vendor", "storage"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
