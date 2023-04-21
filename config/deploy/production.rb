set :stage, :production
set :rails_env, :production
set :deploy_to, '/home/ubuntu/deploy/rails_seven_exploring'

server '44.204.147.56',
  user: 'ubuntu',
  roles: %w{web app db},
  ssh_options: {
    user: 'ubuntu', # overrides user setting above
    keys: %w(~/Downloads/huykeypair.pem),
    forward_agent: false,
    auth_methods: %w(publickey password)
  }
