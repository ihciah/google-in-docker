FROM debian:jessie

ENV NGINX_VERSION 1.11.4
ENV OPENSSL_VERSION 1.0.2j
ENV ZLIB_VERSION 1.2.8
ENV PCRE_VERSION 8.38

RUN apt-get update && apt-get install -y build-essential \
    git \
    gcc \
    g++ \
    make \
    wget \
 && git clone https://github.com/ihciah/ngx_http_google_filter_module \
 && git clone https://github.com/yaoweibin/ngx_http_substitutions_filter_module \
 && wget http://zlib.net/zlib-${ZLIB_VERSION}.tar.gz \
 && wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-${PCRE_VERSION}.tar.gz \
 && wget https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz \
 && wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz \
 && tar xzf zlib-${ZLIB_VERSION}.tar.gz && rm -f zlib-${ZLIB_VERSION}.tar.gz \
 && tar xzf pcre-${PCRE_VERSION}.tar.gz && rm -f pcre-${PCRE_VERSION}.tar.gz \
 && tar xzf openssl-${OPENSSL_VERSION}.tar.gz && rm -f openssl-${OPENSSL_VERSION}.tar.gz \
 && tar xzf nginx-${NGINX_VERSION}.tar.gz && rm -f nginx-${NGINX_VERSION}.tar.gz \
 && cd nginx-${NGINX_VERSION} \
 && ./configure \
 --prefix=/etc/nginx \
 --sbin-path=/usr/sbin/nginx \
 --modules-path=%{_libdir}/nginx/modules \
 --conf-path=/etc/nginx/nginx.conf \
 --error-log-path=/var/log/nginx/error.log \
 --http-log-path=/var/log/nginx/access.log \
 --pid-path=/var/run/nginx.pid \
 --lock-path=/var/run/nginx.lock \
 --http-client-body-temp-path=/var/cache/nginx/client_temp \
 --http-proxy-temp-path=/var/cache/nginx/proxy_temp \
 --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
 --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
 --http-scgi-temp-path=/var/cache/nginx/scgi_temp \
 --user=nginx \
 --group=nginx \
 --with-http_ssl_module \
 --with-http_realip_module \
 --with-http_addition_module \
 --with-http_sub_module \
 --with-http_dav_module \
 --with-http_flv_module \
 --with-http_mp4_module \
 --with-http_gunzip_module \
 --with-http_gzip_static_module \
 --with-http_random_index_module \
 --with-http_secure_link_module \
 --with-http_stub_status_module \
 --with-http_auth_request_module \
 --with-threads \
 --with-stream \
 --with-stream_ssl_module \
 --with-http_slice_module \
 --with-mail \
 --with-mail_ssl_module \
 --with-file-aio \
 --with-http_v2_module \
 --with-ipv6 \
 --add-module=../ngx_http_google_filter_module \
 --add-module=../ngx_http_substitutions_filter_module \
 --with-pcre=../pcre-${PCRE_VERSION} \
 --with-openssl=../openssl-${OPENSSL_VERSION} \
 --with-zlib=../zlib-${ZLIB_VERSION} \
 && make \
 && make install \
 && cd .. \
 && rm -rf nginx-${NGINX_VERSION} \
    zlib-${ZLIB_VERSION} \
    openssl-${OPENSSL_VERSION} \
    pcre-${PCRE_VERSION} \
    ngx_http_google_filter_module \
    ngx_http_substitutions_filter_module \
 && apt-get remove -y build-essential git gcc g++ make wget \
 && apt-get autoremove -y \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN groupadd nginx \
 && useradd --create-home --home-dir /home/nginx -g nginx nginx

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
 && ln -sf /dev/stderr /var/log/nginx/error.log
 
COPY nginx /etc/nginx

RUN nginx -t

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
