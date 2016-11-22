FROM debian:jessie

MAINTAINER datarhei <info@datarhei.org>
ENV RESTREAMER_EDGE_VERSION=0.1.0-rc.4 \
    FFMPEG_VERSION=3.1.2 \
    YASM_VERSION=1.3.0 \
    LAME_VERSION=3_99_5 \
    NGINX_VERSION=1.10.2 \
    NGINX_RTMP_VERSION=master \
    NGINX_NJS=master \
    NGINX_DEVEL_KIT_VERSION=0.3.0 \
    NGINX_STUB_STATUS_PROM=master \
    LUA_NGINX_MODULE_VERSION=0.10.7 \
    LUAJIT_VERSION=2.0.4 \
    LUAJIT_MAJOR_VERSION=2.0 \
    LUAJIT_LIB=/usr/local/lib \
    LUAJIT_INC=/usr/local/include/luajit-2.0 \

    SRC="/usr/local" \
    LD_LIBRARY_PATH="${SRC}/lib" \
    PKG_CONFIG_PATH="${SRC}/lib/pkgconfig" \

    BUILDDEPS="autoconf automake gcc g++ libtool make nasm unzip zlib1g-dev libssl-dev xz-utils cmake build-essential libpcre3-dev"

RUN rm -rf /var/lib/apt/lists/* && \
    apt-get update && \
    apt-get install -y --force-yes --fix-missing apt-utils && \
    apt-get upgrade -y && \
    apt-get install -y --force-yes --fix-missing curl git libpcre3 tar perl ca-certificates apache2-utils libaio1 libxml2 libxslt-dev ${BUILDDEPS} && \

    # yasm
    DIR="$(mktemp -d)" && cd "${DIR}" && \
    curl -LOks "https://www.tortall.net/projects/yasm/releases/yasm-${YASM_VERSION}.tar.gz" && \
    tar xzvf "yasm-${YASM_VERSION}.tar.gz" && \
    cd "yasm-${YASM_VERSION}" && \
    ./configure \
        --prefix="${SRC}" \
        --bindir="${SRC}/bin" && \
    make -j"$(nproc)" && \
    make install && \
    make distclean && \
    rm -rf "${DIR}" && \

    # x264
    DIR="$(mktemp -d)" && cd "${DIR}" && \
    git clone --depth 1 "git://git.videolan.org/x264" && \
    cd x264 && \
    ./configure \
        --prefix="${SRC}" \
        --bindir="${SRC}/bin" \
        --enable-static \
        --disable-cli && \
    make -j"$(nproc)" && \
    make install && \
    make distclean && \
    rm -rf "${DIR}" && \

    # libmp3lame
    DIR="$(mktemp -d)" && cd "${DIR}" && \
    curl -LOks "https://github.com/rbrito/lame/archive/RELEASE__${LAME_VERSION}.tar.gz" && \
    tar xzvf "RELEASE__${LAME_VERSION}.tar.gz" && \
    cd "lame-RELEASE__${LAME_VERSION}" && \
    ./configure \
        --prefix="${SRC}" \
        --bindir="${SRC}/bin" \
        --enable-nasm \
        --disable-shared && \
    make -j"$(nproc)" && \
    make install && \
    make distclean && \
    rm -rf "${DIR}" && \

    # ffmpeg
    DIR="$(mktemp -d)" && cd "${DIR}" && \
    curl -LOks "https://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.gz" && \
    tar xzvf "ffmpeg-${FFMPEG_VERSION}.tar.gz" && \
    cd "ffmpeg-${FFMPEG_VERSION}" && \
    ./configure \
        --prefix="${SRC}" \
        --bindir="${SRC}/bin" \
        --extra-cflags="-I${SRC}/include" \
        --extra-ldflags="-L${SRC}/lib" \
        --extra-libs=-ldl \
        --enable-nonfree \
        --enable-gpl \
        --enable-version3 \
        --enable-avresample \
        --enable-libmp3lame \
        --enable-libx264 \
        --enable-openssl \
        --enable-postproc \
        --enable-small \
        --disable-debug \
        --disable-doc \
        --disable-ffserver && \
    make -j"$(nproc)" && \
    make install && \
    make distclean && \
    hash -r && \
    cd tools && \
    make qt-faststart && \
    cp qt-faststart "${SRC}/bin" && \
    rm -rf "${DIR}" && \
    echo "${SRC}/lib" > "/etc/ld.so.conf.d/libc.conf" && \
    ffmpeg -buildconf && \

    # LuaJIT
    DIR=$(mktemp -d) && cd ${DIR} && \
    curl -LOks "http://luajit.org/download/LuaJIT-${LUAJIT_VERSION}.zip" && \
    unzip LuaJIT-${LUAJIT_VERSION} && \
    cd LuaJIT-${LUAJIT_VERSION} && \
    make install && \
    ln -sf luajit-${LUAJIT_VERSION} /usr/local/bin/luajit && \
    rm -rf ${DIR}

    # nginx-rtmp
RUN DIR=$(mktemp -d) && cd ${DIR} && \
    curl -LOks "https://github.com/nginx/nginx/archive/release-${NGINX_VERSION}.tar.gz" && \
    tar xzvf "release-${NGINX_VERSION}.tar.gz" && \
    curl -LOks "https://github.com/sergey-dryabzhinsky/nginx-rtmp-module/archive/${NGINX_RTMP_VERSION}.tar.gz" && \
    tar xzvf "${NGINX_RTMP_VERSION}.tar.gz" && \
    curl -LOks https://github.com/nginx/njs/archive/${NGINX_NJS}.zip && \
    unzip ${NGINX_NJS}.zip && \
    curl -LOks "https://github.com/simpl/ngx_devel_kit/archive/v${NGINX_DEVEL_KIT_VERSION}.zip" -O && \
    unzip v${NGINX_DEVEL_KIT_VERSION}.zip && \
    curl -LOks "https://github.com/openresty/lua-nginx-module/archive/v${LUA_NGINX_MODULE_VERSION}.zip" && \
    unzip v${LUA_NGINX_MODULE_VERSION}.zip && \
    curl -LOks "https://github.com/mhowlett/ngx_stub_status_prometheus/archive/${NGINX_STUB_STATUS_PROM}.zip" && \
    unzip ${NGINX_STUB_STATUS_PROM}.zip && \
    cd nginx-release-${NGINX_VERSION} && \
    auto/configure \
        --with-http_ssl_module \
        --with-http_xslt_module \
        --with-ld-opt="-Wl,-rpath,/usr/local/lib/lua" \
        --with-http_ssl_module \
        --with-http_realip_module \
        --with-http_stub_status_module \
        --add-dynamic-module="../njs-${NGINX_NJS}/nginx" \
        --add-dynamic-module="../nginx-rtmp-module-${NGINX_RTMP_VERSION}" \
        --add-module="../ngx_devel_kit-${NGINX_DEVEL_KIT_VERSION}" \
        --add-module="../lua-nginx-module-${LUA_NGINX_MODULE_VERSION}" \
        --add-dynamic-module="../ngx_stub_status_prometheus-${NGINX_STUB_STATUS_PROM}" && \
    make -j"$(nproc)" && \
    make install && \
    cp ../nginx-rtmp-module-${NGINX_RTMP_VERSION}/stat.xsl /usr/local/nginx/html/info.xsl && \
    curl -LOks "https://raw.githubusercontent.com/espizo/simple-nginx-rtmp/master/www/entities.dtd" && \
    mv entities.dtd /usr/local/nginx/conf/ && \
    curl -LOks "https://raw.githubusercontent.com/espizo/simple-nginx-rtmp/master/www/xml2json.xsl" && \
    mv xml2json.xsl /usr/local/nginx/conf/ && \
    rm -rf ${DIR} && \
        
    # letsencrypt
    cd /opt && \
    curl -LOks https://dl.eff.org/certbot-auto && \
    chmod a+x ./certbot-auto && \
    ./certbot-auto --os-packages-only --noninteractive && \
    
    # clappr-player
    DIR=$(mktemp -d) && cd ${DIR} && \
    curl -LOks "https://github.com/clappr/clappr/archive/master.tar.gz" && \
    tar xzvf "master.tar.gz" && \
    rm master.tar.gz && \
    curl -LOks "https://github.com/clappr/clappr-level-selector-plugin/archive/master.tar.gz" && \
    tar xzvf "master.tar.gz" && \
    rm master.tar.gz && \
    mv * /usr/local/nginx/html && \
    rm -rf ${DIR} && \

    # prometheus exporter
    cd /usr/local/nginx/ && \
    curl -LOks "https://raw.githubusercontent.com/knyar/nginx-lua-prometheus/master/prometheus.lua" && \

    apt-get purge -y --auto-remove ${BUILDDEPS} && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* \
        /tmp/* \
        /var/tmp/*

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
