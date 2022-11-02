FROM jwilder/nginx-proxy:alpine as nginx-base

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
  && ln -sf /dev/stderr /var/log/nginx/error.log

COPY nginx.conf.tpl /etc/nginx/
RUN rm -f /etc/nginx/conf.d/*.conf
COPY frontend-from-rails.conf /etc/nginx/default.d/frontend-location.conf
COPY docker-entrypoint.sh ./
RUN chmod +x ./docker-entrypoint.sh

# Ensure graceful shutdown
# https://ubuntu.com/blog/avoiding-dropped-connections-in-nginx-containers-with-stopsignal-sigquit
STOPSIGNAL SIGQUIT

ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
