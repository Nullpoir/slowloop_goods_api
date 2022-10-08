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

# ---------------------------------------------------

# Nginx image with basic authentication and assets distribution
# FROM nginx-base

# ARG BASIC_AUTH_USERNAME
# ARG BASIC_AUTH_PASSWORD

# RUN if [ -z $BASIC_AUTH_USERNAME ]; then echo >&2 "BASIC_AUTH_USERNAME must be set" && exit 1; fi
# RUN if [ -z $BASIC_AUTH_PASSWORD ]; then echo >&2 "BASIC_AUTH_PASSWORD must be set" && exit 1; fi
# RUN apk add --update apache2-utils
# RUN htpasswd -bBc /etc/nginx/.htpasswd $BASIC_AUTH_USERNAME $BASIC_AUTH_PASSWORD

# RUN rm -f /etc/nginx/conf.d/*.conf
# COPY frontend-from-nginx-with-auth.conf /etc/nginx/conf.d/frontend-location.conf