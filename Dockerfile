ARG FFMPEG_IMAGE=datarhei/ffmpeg:3
ARG ALPINE_IMAGE=alpine:latest

FROM $FFMPEG_IMAGE as ffmpeg

ENV NGINX_VERSION=1.13.5 \
    NGINX_RTMP_VERSION=dev \
    NGINX_DEVEL_KIT_VERSION=0.3.0 \
    NGINX_STUB_STATUS_PROM=master \
    NGINX_NJS=master \
    LUA_NGINX_MODULE_VERSION=0.10.10 \
    PKG_CONFIG_PATH=/usr/local/lib/pkgconfig \
    SRC=/usr/local

RUN export buildDeps="autoconf \
        automake \
        bash \
        binutils \
        bzip2 \
        cmake \
        curl \
        coreutils \
        g++ \
        gcc \
        gnupg \
        libtool \
        make \
        python \
        openssl-dev \
        tar \
        xz \
        git \
        pcre-dev \
        zlib-dev" && \
    export MAKEFLAGS="-j$(($(grep -c ^processor /proc/cpuinfo) + 1))" && \
    apk add --update ${buildDeps} libgcc libstdc++ ca-certificates libssl1.0 libxslt-dev libxml2-dev lua lua-dev luajit luajit-dev && \

    DIR=$(mktemp -d) && cd ${DIR} && \
    curl -LOks "https://github.com/nginx/nginx/archive/release-${NGINX_VERSION}.tar.gz" && \
    tar xzvf "release-${NGINX_VERSION}.tar.gz" && \
    curl -LOks "https://github.com/sergey-dryabzhinsky/nginx-rtmp-module/archive/${NGINX_RTMP_VERSION}.tar.gz" && \
    tar xzvf "${NGINX_RTMP_VERSION}.tar.gz" && \
    curl -LOks "https://github.com/simpl/ngx_devel_kit/archive/v${NGINX_DEVEL_KIT_VERSION}.zip" -O && \
    unzip v${NGINX_DEVEL_KIT_VERSION}.zip && \
    curl -LOks "https://github.com/openresty/lua-nginx-module/archive/v${LUA_NGINX_MODULE_VERSION}.zip" && \
    unzip v${LUA_NGINX_MODULE_VERSION}.zip && \
    curl -LOks "https://github.com/mhowlett/ngx_stub_status_prometheus/archive/${NGINX_STUB_STATUS_PROM}.zip" && \
    unzip ${NGINX_STUB_STATUS_PROM}.zip && \
    curl -LOks https://github.com/nginx/njs/archive/${NGINX_NJS}.zip && \
    unzip ${NGINX_NJS}.zip && \
    cd nginx-release-${NGINX_VERSION} && \
    auto/configure \
        --with-http_ssl_module \
        --with-http_xslt_module \
        --with-ld-opt="-Wl,-rpath,/usr/local/lib/lua" \
        --with-http_realip_module \
        --with-http_stub_status_module \
        --add-module="../nginx-rtmp-module-${NGINX_RTMP_VERSION}" \
        --add-module="../ngx_devel_kit-${NGINX_DEVEL_KIT_VERSION}" \
        --add-dynamic-module="../njs-${NGINX_NJS}/nginx" \
        --add-dynamic-module="../lua-nginx-module-${LUA_NGINX_MODULE_VERSION}" \
        --add-dynamic-module="../ngx_stub_status_prometheus-${NGINX_STUB_STATUS_PROM}" && \
    make && \
    make install && \
    cp ../nginx-rtmp-module-${NGINX_RTMP_VERSION}/stat.xsl /usr/local/nginx/html/info.xsl && \
    curl -LOks "https://raw.githubusercontent.com/espizo/simple-nginx-rtmp/master/www/entities.dtd" && \
    mv entities.dtd /usr/local/nginx/conf/ && \
    curl -LOks "https://raw.githubusercontent.com/espizo/simple-nginx-rtmp/master/www/xml2json.xsl" && \
    mv xml2json.xsl /usr/local/nginx/conf/ && \
    rm -rf ${DIR} && \
    cd /usr/local/nginx/ && \
    curl -LOks "https://raw.githubusercontent.com/knyar/nginx-lua-prometheus/master/prometheus.lua" && \
    
    DIR=$(mktemp -d) && cd ${DIR} && \
    curl -LOks "https://github.com/clappr/clappr/archive/master.tar.gz" && \
    tar xzvf "master.tar.gz" && \
    rm master.tar.gz && \
    curl -LOks "https://github.com/clappr/clappr-level-selector-plugin/archive/master.tar.gz" && \
    tar xzvf "master.tar.gz" && \
    rm master.tar.gz && \
    mv * /usr/local/nginx/html && \
    rm -rf ${DIR}

FROM $ALPINE_IMAGE

MAINTAINER datarhei <info@datarhei.org>

ENV RESTREAMER_EDGE_VERSION=0.1.0 \
    SRC=/usr/local \
    LD_LIBRARY_PATH=/usr/local/lib \
    PKG_CONFIG_PATH=/usr/local/lib/pkgconfig 

COPY --from=ffmpeg /usr/local/bin/ffmpeg /usr/local/bin/ffmpeg
COPY --from=ffmpeg /usr/local/bin/ffprobe /usr/local/bin/ffprobe
COPY --from=ffmpeg /usr/local/nginx /usr/local/nginx
COPY --from=ffmpeg /usr/local/lib /usr/local/lib

RUN apk add --no-cache --update libssl1.0 libxml2 libxslt pcre apache2-utils lua luajit certbot && \
    ffmpeg -buildconf
    
ADD templates /templates
ADD favicon.ico /usr/local/nginx/html/favicon.ico
ADD run.sh /run.sh
ADD snapshot.sh /snapshot.sh
RUN mkdir /usr/local/nginx/conf/vhost && \
    mkdir /usr/local/nginx/conf/vhost/www && \
    mkdir /usr/local/nginx/conf/vhost/rtmp && \
    mkdir /usr/local/nginx/html/images && \
    chmod 777 /usr/local/nginx/html/images && \
    chmod +x /run.sh && \
    chmod +x /snapshot.sh && \
    chmod 777 /snapshot.sh

ENV WORKER_PROCESSES=1 \
    WORKER_CONNECTIONS=1024 \
    
    RTMP_ACCESS_LOG=off \

    RTMP_SRV_PORT=1935 \
    RTMP_SRV_TIMEOUT=60s \
    RTMP_SRV_PING=3m \
    RTMP_SRV_PING_TIMEOUT=30s \
    RTMP_SRV_MAX_STREAMS=32 \
    RTMP_SRV_ACK_WINDOW=5000000 \
    RTMP_SRV_CHUNK_SIZE=4096 \
    RTMP_SRV_MAX_MESSAGE=1M \
    RTMP_SRV_BUFLEN=5s \
    
    RTMP_SRV_APP_HLS_INTERLEAVE=on \
    RTMP_SRV_APP_HLS_META=copy \
    RTMP_SRV_APP_HLS_WAIT_KEY=on \
    RTMP_SRV_APP_HLS_WAIT_VIDEO=on \
    RTMP_SRV_APP_HLS_DROP_IDLE_PUBLISHER=10s \
    RTMP_SRV_APP_HLS_SYNC=10ms \
    RTMP_SRV_APP_HLS_IDLE_STREAMS=off \
    
    RTMP_SRV_APP_HLS_HLS_FRAGMENT=2s \
    RTMP_SRV_APP_HLS_HLS_PLAYLIST_LENGTH=60 \
    RTMP_SRV_APP_HLS_HLS_SYNC=1ms \
    RTMP_SRV_APP_HLS_HLS_CONTINOUS=off \
    RTMP_SRV_APP_HLS_HLS_NESTED=off \
    RTMP_SRV_APP_HLS_HLS_CLEANUP=on \
    RTMP_SRV_APP_HLS_HLS_FRAGMENT_NAMING=sequential \
    RTMP_SRV_APP_HLS_HLS_FRAGMENT_NAMING_GRANULARITY=0 \
    RTMP_SRV_APP_HLS_HLS_FRAGMENT_SLICING=plain \
    RTMP_SRV_APP_HLS_HLS_TYPE=live \
    RTMP_SRV_APP_HLS_HLS_KEY=off \
    RTMP_SRV_APP_HLS_HLS_FRAGMENTS_PER_KEY=0 \
    
    RTMP_SRV_APP_HLS_SNAPSHOT_INTERVAL=60 \
    RTMP_SRV_APP_HLS_TRANSCODING=false \
    RTMP_SRV_APP_HLS_TRANSCODING_PROFILES=240p,360p,480p,720p,native \
    
    RTMP_PUBLISH_TOKEN=datarhei \

    HTTP_SENDFILE=on \
    HTTP_TCP_NOPUSH=on \
    HTTP_TCP_NODELAY=on \
    HTTP_ACCESS_LOG=off \

    HTTP_SRV_PORT=80 \
    HTTP_SRV_LOC_HLS_ACCESS_CONTROL_ALLOW_ORIGIN=* \
    
    HTTP_AUTH_USERNAME=admin \
    HTTP_AUTH_PASSWORD=datarhei \
    
    HTTPS_SRV=false \
    HTTPS_SRV_PORT=443 \
    HTTPS_SRV_CERT_DOMAIN=example.org \
    
    HTTPS_LETSENCRYPT=false \
    HTTPS_LETSENCRYPT_MAIL=admin@example.org \
    
    PLAYER_CREATE=true \
    
    PLAYER_WATERMARK_SOURCE=none \
    PLAYER_WATERMARK_POSITION=top-right \
    PLAYER_WATERMARK_LINK=none \

    PLAYER_COLOR_BUTTONS=3daa48 \
    PLAYER_COLOR_SEEKBAR=3daa48 \

    PLAYER_GA_ACCOUNT=none \
    PLAYER_GA_TRACKERNAME=datarheiEdge

CMD ["/run.sh"]