# Deploy rails app với Capistrano & Passenger(zero downtime) :star_struck: :star_struck: :star_struck: :star_struck: :star_struck: :star_struck: :star_struck: :star_struck: :star_struck: :star_struck: :star_struck:

quá dễ luông :partying_face:

:notebook: :notebook: :notebook: :notebook: :notebook: :notebook: :notebook: :notebook: :notebook: :notebook: :notebook: :notebook: :notebook: :notebook: :notebook: :notebook: :notebook: :notebook: :notebook: :notebook: :notebook: :notebook: :notebook: :notebook: :notebook: :notebook:

## Cài môi trường trên server:

- rvm & ruby
- nvm & nodejs
- yarn (cài thông qua npm)
- postgresql, mysql, ...
- nginx & passenger

Cài rvm & ruby thần tốc

    https://linux.how2shout.com/how-to-install-rvm-ruby-version-manager-on-ubuntu-20-04-lts/

Cài nginx & passenger

    https://gorails.com/deploy/ubuntu/20.04#nginx

Một số thư viện khác (không cần thiết lắm nhưng note vô để sau này copy cho tiện) :notebook_with_decorative_cover:

    sudo apt install build-essential libreadline-dev libxml2-dev libxslt1-dev libcurl4-openssl-dev libmysqlclient-dev

## Tạo cấu trúc thư mục deploy:

    mkdir -p deploy/projec_name/shared/config && cd $_
    touch application.yml database.yml

Trong file database.yml

    production:
      adapter: mysql2
      encoding: utf8mb4
      pool: 5
      database: <database name>
      username: root
      password:
      socket: /var/run/mysqld/mysqld.sock

## Config nginx & passenger:

    sudo rm /etc/nginx/sites-enabled/default
    sudo vi /etc/nginx/sites-enabled/rails_seven_exploring

Nội dung file config

```
server {
  listen 80;
  listen [::]:80;

  server_name _;
  root /home/ubuntu/deploy/rails_seven_exploring/current/public;

  passenger_enabled on;
  passenger_app_env production;

  location /cable {
    passenger_app_group_name rails_seven_exploring_websocket;
    passenger_force_max_concurrent_requests_per_process 0;
  }

  # Allow uploads up to 100MB in size
  client_max_body_size 100m;

  location ~ ^/(assets|packs) {
    expires max;
    gzip_static on;
  }
}
```

Nếu có nhiều version ruby thì chạy `$ passenger-config about ruby-command` để lấy path và copy như ví dụ này

    passenger_ruby /home/ubuntu/.rvm/gems/ruby-3.2.1/wrappers/ruby 

Reload nginx và load các server files mới :tada: :cake:

    sudo service nginx reload
