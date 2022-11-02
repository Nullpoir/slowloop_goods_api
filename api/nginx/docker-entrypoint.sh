#!/bin/sh -e

envsubst '$$NGINX_UPSTREAM' < /etc/nginx/nginx.conf.tpl > /etc/nginx/nginx.conf
exec "$@"