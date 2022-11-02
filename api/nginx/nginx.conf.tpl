# For more information on configuration, see:
#   * Official English Documentation: http://nginx.org/en/docs/
#   * Official Russian Documentation: http://nginx.org/ru/docs/

user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /var/run/nginx.pid;

# Load dynamic modules. See /usr/share/doc/nginx/README.dynamic.
include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 1024;
    multi_accept on;
}

http {
    map $upstream_response_time $temprt {
           default $upstream_response_time;
           ""      null;
       }

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    log_format  json  escape=json '{"time": "$time_iso8601",'
           '"host": "$remote_addr",'
           '"vhost": "$host",'
           '"user": "$remote_user",'
           '"status": $status,'
           '"protocol": "$server_protocol",'
           '"method": "$request_method",'
           '"path": "$request_uri",'
           '"req": "$request",'
           '"size": $body_bytes_sent,'
           '"reqtime": $request_time,'
           '"apptime": $temprt,'
           '"ua": "$http_user_agent",'
           '"forwardedfor": "$http_x_forwarded_for",'
           '"forwardedproto": "$http_x_forwarded_proto",'
           '"referrer": "$http_referer"}';

    access_log  /var/log/nginx/access.log  main;
    access_log  /var/log/nginx/access.log.json  json;

    charset utf-8;
    server_tokens       off;
    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 2048;
    client_max_body_size 20M;

    gzip on;
    gzip_disable "msie6";
    gzip_comp_level 5;
    gzip_min_length 256;
    gzip_proxied any;
    gzip_vary on;
    gzip_buffers 16 8k;
    gzip_http_version 1.1;
    gzip_types text/plain text/css application/json application/x-javascript text/xml application/xml application/xml+rss application/javascript image/gif image/png image/jpeg text/csv;

    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;

    # For WebSocket proxying: http://nginx.org/en/docs/http/websocket.html
    map $http_upgrade $connection_upgrade {
        default upgrade;
        ''      close;
    }
    map $http_origin $cors_origin_header {
        hostnames;
        default "";
        localhost "$http_origin";
        "~^minio(:[0-9]{1,4})?$" "$http_origin";
        "~^localhost(:[0-9]{1,4})?$" "$http_origin";
        "*.lvh.me(:[0-9]{1,4})?$" "$http_origin";
        *.lvh.me "$http_origin";
    }

    map $http_origin $cors_cred {
        hostnames;
        default "";
        localhost "true";
        "~^http:\/\/minio(:[0-9]{1,4})?$" "true";
        "~^http:\/\/localhost(:[0-9]{1,4})?$" "true";
        "~^http:\/\/*.lvh.me(:[0-9]{1,4})?$" "true";
        *.lvh.me "true";
    }

    # Load modular configuration files from the /etc/nginx/conf.d directory.
    # See http://nginx.org/en/docs/ngx_core_module.html#include
    # for more information.
    include /etc/nginx/conf.d/*.conf;

    index   index.html index.htm;

    # upstream puma_gacha {
    #     server unix:{{ app_path }}shared/tmp/sockets/puma.sock;
    # }

    upstream backend {
        server ${NGINX_UPSTREAM};
    }

    server {
        listen       80 default_server;
        listen       [::]:80 default_server;

        # "upstream sent too big header while reading response header from upstream" エラーを回避するためのチューニング
        # 参考: https://www.getpagespeed.com/server-setup/nginx/tuning-proxy_buffer_size-in-nginx
        # 制約: proxy_buffer_size <= proxy_busy_buffers_size < (proxy_buffers.count - 1) * proxy_buffer_size
        proxy_buffer_size       16k;   # デフォルトの4KBは小さすぎるので16KBに引き上げ
        proxy_busy_buffers_size 24k;   # proxy_buffer_size (16KB) + 予備バッファ(メモリページサイズ(8KB) x 2)
        proxy_buffers           24 8k; # デフォルトのバッファ数8個は少なすぎるので24個に引き上げ

        # server_name  _;
        server_name *.lvh.me *.localhost;
        # root         {{ app_path }}current/public;
        try_files $uri/index.html $uri @app;

        client_max_body_size 4G;
        keepalive_timeout 10;

        set_real_ip_from 172.31.0.0/16;
        real_ip_header   X-Forwarded-For;

        # Load configuration files for the default server block.
        # include /etc/nginx/default.d/*.conf;

        set $redirect "";
        if ($http_x_forwarded_proto = 'http'){
            set $redirect "${redirect}1";
        }
        if ($http_user_agent !~* ELB-HealthChecker) {
            set $redirect "${redirect}1";
        }
        if ($redirect = "11") {
            return 301 https://$host$request_uri;
        }

        location @app {
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header Host $http_host;
            proxy_set_header X-Forwarded-Host  $http_host;
            proxy_redirect off;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection "Upgrade";
            proxy_set_header X-Forwarded-Proto $http_x_forwarded_proto;
            proxy_pass http://backend;
        }

        location ^~ /assets/ {
            gzip_static on;
            expires max;
            add_header Cache-Control public;
        }

        error_page 404 /404.html;
            location = /40x.html {
        }

        error_page 422 /422.html;
            location = /422.html {
        }

        error_page 500 502 503 504 /500.html;
            location = /500.html {
        }

        location = /ping {
            access_log off;
            proxy_pass http://backend;
        }

        location = /api/ping {
            access_log off;
            proxy_pass http://backend;
        }

        location /api/ {
            # Append CORS headers for responses to preflight requests
            if ($request_method = OPTIONS) {
                add_header Access-Control-Allow-Origin $cors_origin_header always;
                add_header Access-Control-Allow-Methods "GET, POST, PATCH, PUT, DELETE, OPTIONS, HEAD";
                # Always allowed headers: Accept, Accept-Language, Content-Language, Content-Type
                add_header Access-Control-Allow-Headers "Authorization, Origin, X-Requested-With";
                # Always exposed headers: Cache-Control, Content-Language, Content-Type, Expires, Last-Modified, Pragma
                add_header Access-Control-Expose-Headers "Content-Disposition, Content-Length";
                add_header Access-Control-Max-Age 60;
                add_header Content-Length 0;
                return 200;
            }
            # Seems duplicate, but actually necessary to append Access-Control-Allow-Origin header even when
            # the request method is not OPTIONS. See https://www.nginx.com/resources/wiki/start/topics/depth/ifisevil
            add_header Access-Control-Allow-Origin $cors_origin_header always;

            proxy_next_upstream off;

            proxy_set_header Host $http_host;

            proxy_set_header HTTPS on;
            proxy_set_header X-Forwarded-Ssl on;

            proxy_set_header X-CSRF-Token $http_x_csrf_token; # forwarded by ALB

            proxy_redirect off;
            proxy_pass http://backend;

            # To prevent timeout during long-running batch processing
            keepalive_timeout 86400;
            send_timeout 86400;
            proxy_read_timeout 86400;
        }

        location /cable {
            proxy_next_upstream off;
            proxy_redirect off;
            proxy_pass http://backend/cable;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection $connection_upgrade;
            proxy_read_timeout 300;
        }

        location /health {
            access_log off;
            empty_gif;
            break;
        }

        include default.d/frontend-location.conf;
    }

    server {
        listen 12345;
        server_name localhost;
        location /nginx_status {
            stub_status on;
            access_log off;
        }
    }
}
