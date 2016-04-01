#!/bin/bash

# SET IMAGE FOLDER PERM
chmod 777 /usr/local/nginx/html/images -R

# ENABLE MULTIWORKER IF REQUIRED
if [ "${WORKER_PROCESSES}" = "1" ]
then
	export RTMP_AUTO_PUSH=off
else
	export RTMP_AUTO_PUSH=on
fi

# INIT
printf "$(date '+%Y/%m/%d %H:%M:%S') [info]      _       _             _           _ \n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info]   __| | __ _| |_ __ _ _ __| |___   ___(_)\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info]  / _  |/ _  | __/ _  |  __|  _  |/  _ | |\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] | (_| | (_| | || (_| | |  | | | |  __/| |\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] |_____|_____|_||_____|_|  |_| |_|____||_|\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] \n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] Restreamer-Edge v${RESTREAMER_EDGE_VERSION}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] https://datarhei.github.com/restreamer-edge\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] \n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENVIRONMENTS\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] More informations in our Docs\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] \n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV WORKER_PROCESSES ${WORKER_PROCESSES}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV WORKER_CONNECTIONS ${WORKER_CONNECTIONS}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_AUTO_PUSH ${RTMP_AUTO_PUSH}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_ACCESS_LOG ${RTMP_ACCESS_LOG}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SERVER_PORT ${RTMP_SERVER_PORT}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SERVER_TIMEOUT ${RTMP_SERVER_TIMEOUT}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SERVER_PING ${RTMP_SERVER_PING}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SERVER_PING_TIMEOUT ${RTMP_SERVER_PING_TIMEOUT}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SERVER_MAX_STREAMS ${RTMP_SERVER_MAX_STREAMS}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SERVER_ACK_WINDOW ${RTMP_SERVER_ACK_WINDOW}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SERVER_CHUNK_SIZE ${RTMP_SERVER_CHUNK_SIZE}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SERVER_MAX_MESSAGE ${RTMP_SERVER_MAX_MESSAGE}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SERVER_BUFLEN ${RTMP_SERVER_BUFLEN}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SERVER_HLS_FRAGMENT ${RTMP_SERVER_HLS_FRAGMENT}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SERVER_HLS_PLAYLIST_LENGTH ${RTMP_SERVER_HLS_PLAYLIST_LENGTH}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SERVER_HLS_SYNC ${RTMP_SERVER_HLS_SYNC}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SERVER_HLS_CONTINOUS ${RTMP_SERVER_HLS_CONTINOUS}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SERVER_HLS_NESTED ${RTMP_SERVER_HLS_NESTED}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SERVER_HLS_CLEANUP ${RTMP_SERVER_HLS_CLEANUP}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SERVER_HLS_FRAGMENT_NAMING ${RTMP_SERVER_HLS_FRAGMENT_NAMING}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SERVER_HLS_FRAGMENT_NAMING_GRANULARITY ${RTMP_SERVER_HLS_FRAGMENT_NAMING_GRANULARITY}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SERVER_HLS_FRAGMENT_SLICING ${RTMP_SERVER_HLS_FRAGMENT_SLICING}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SERVER_HLS_TYPE ${RTMP_SERVER_HLS_TYPE}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SERVER_HLS_KEY ${RTMP_SERVER_HLS_KEY}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SERVER_HLS_FRAGMENTS_PER_KEY ${RTMP_SERVER_HLS_FRAGMENTS_PER_KEY}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SERVER_HLS_MAX_CONNECTIONS ${RTMP_SERVER_HLS_MAX_CONNECTIONS}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SERVER_HLS_SNAPSHOT_INTERVAL ${RTMP_SERVER_HLS_SNAPSHOT_INTERVAL}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SERVER_HLS_TRANSCODING ${RTMP_SERVER_HLS_TRANSCODING}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SERVER_HLS_TRANSCODING_PROFILES ${RTMP_SERVER_HLS_TRANSCODING_PROFILES}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SERVER_HLS_PUBLISH_TOKEN ${RTMP_SERVER_HLS_PUBLISH_TOKEN}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV HTTP_SENDFILE ${HTTP_SENDFILE}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV HTTP_TCP_NOPUSH ${HTTP_TCP_NOPUSH}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV HTTP_TCP_NODELAY ${HTTP_TCP_NODELAY}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV HTTP_ACCESS_LOG ${HTTP_ACCESS_LOG}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV HTTP_SERVER_PORT ${HTTP_SERVER_PORT}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV HTTP_SERVER_HLS_ACCESS_CONTROL_ALLOW_ORIGIN ${HTTP_SERVER_HLS_ACCESS_CONTROL_ALLOW_ORIGIN}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV HTTPS_SERVER ${HTTPS_SERVER}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV HTTPS_SERVER_PORT ${HTTPS_SERVER_PORT}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV HTTPS_CERT_MAIL ${HTTPS_CERT_MAIL}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV HTTPS_CERT_DOMAIN ${HTTPS_CERT_DOMAIN}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] \n"

# CREATE BASIC AUTH
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] " && htpasswd -bc /usr/local/nginx/conf/status.htpasswd ${HTTP_SERVER_HLS_STATUS_USERNAME} ${HTTP_SERVER_HLS_STATUS_PASSWORD}
printf "\n"

# CREATE SSL CERTS
if [ "${HTTPS_SERVER}" = "true" ]
then
    DOMAINS=$(echo ${HTTPS_CERT_DOMAIN} | sed 's/,/ -d /g')
    /opt/letsencrypt/letsencrypt-auto certonly --no-self-upgrade --renew-by-default --http-01-port 63443 --agree-tos --email ${HTTPS_CERT_MAIL} -d ${DOMAINS}
fi

# CREATE NGINX.CONF
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] Creating nginx.conf\n"
sed  "s|##WORKER_PROCESSES##|${WORKER_PROCESSES}|;s|##WORKER_CONNECTIONS##|${WORKER_CONNECTIONS}|;s|##RTMP_AUTO_PUSH##|${RTMP_AUTO_PUSH}|;s|##HTTP_SENDFILE##|${HTTP_SENDFILE}|;s|##HTTP_TCP_NOPUSH##|${HTTP_TCP_NOPUSH}|;s|##HTTP_TCP_NODELAY##|${HTTP_TCP_NODELAY}|;s|##RTMP_ACCESS_LOG##|${RTMP_ACCESS_LOG}|;s|##HTTP_ACCESS_LOG##|${HTTP_ACCESS_LOG}|" /templates/nginx.tmpl > /usr/local/nginx/conf/nginx.conf

# CREATE VHOST WWW HTTP
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] Creating www/http vhost\n"
sed  "s|##HTTP_SERVER_PORT##|${HTTP_SERVER_PORT}|;s|##RTMP_SERVER_HLS_PUBLISH_TOKEN##|${RTMP_SERVER_HLS_PUBLISH_TOKEN}|;s|##HTTP_SERVER_HLS_ACCESS_CONTROL_ALLOW_ORIGIN##|${HTTP_SERVER_HLS_ACCESS_CONTROL_ALLOW_ORIGIN}|" /templates/nginx-vhost-www-http.tmpl > /usr/local/nginx/conf/vhost/www/http.conf

# CREATE VHOST WWW HTTPS
if [ "${HTTPS_SERVER}" = "true" ]
then
    CERT_NAME=$(echo ${HTTPS_CERT_DOMAIN} | cut -d ',' -f1)
    printf "$(date '+%Y/%m/%d %H:%M:%S') [info] Creating www/https vhost\n"
    sed  "s|##HTTPS_SERVER_PORT##|${HTTPS_SERVER_PORT}|;s|##CERT_NAME##|${CERT_NAME}|;s|##RTMP_SERVER_HLS_PUBLISH_TOKEN##|${RTMP_SERVER_HLS_PUBLISH_TOKEN}|;s|##HTTP_SERVER_HLS_ACCESS_CONTROL_ALLOW_ORIGIN##|${HTTP_SERVER_HLS_ACCESS_CONTROL_ALLOW_ORIGIN}|" /templates/nginx-vhost-www-https.tmpl > /usr/local/nginx/conf/vhost/www/https.conf
fi

# CREATE VHOST RTMP HLS
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] Creating rtmp/hls vhost\n"
if [ ${RTMP_SERVER_HLS_TRANSCODING} = "true" ]
then
    RTMPSERVER=nginx-vhost-rtmp-hls-transcoding
    PROFILES=$(echo $RTMP_SERVER_HLS_TRANSCODING_PROFILES | sed 's/,/ /g')
    
    # ADD FFMPEG COMMAND
    FFMPEG_COMMAND=$(cd /templates/ffmpeg_profiles && cat $PROFILES)
    echo $FFMPEG_COMMAND > /tmp/ffmpeg_command.tmp
    sed -i -e "/##FFMPEG_COMMAND##/r /tmp/ffmpeg_command.tmp" -e "//d" /templates/$RTMPSERVER.tmpl
    sed -i "s/##RTMP_SERVER_PORT##/${RTMP_SERVER_PORT}/g" /templates/$RTMPSERVER.tmpl
    
    # ADD HLS VARIANT
    i=0
    for profile in $PROFILES
    do
       PROFILE_CONTENT=$(cat /templates/hls_variant/"$profile")
       printf "$PROFILE_CONTENT\n" >> /tmp/hls_variant.tmp
    done
    sed -i '1!G;h;$!d' /tmp/hls_variant.tmp
    sed -i -e "/##HLS_VARIANT##/r /tmp/hls_variant.tmp" -e "//d" /templates/$RTMPSERVER.tmpl
    
    # ADD PLAYER PROFILES
    i=0
    for profile in $PROFILES
    do
        echo "$((i++)): '$profile'," >> /tmp/player_transcoding_profile.tmp
    done
    sed -i '1!G;h;$!d' /tmp/player_transcoding_profile.tmp 
    sed -i -e "/##FFMPEG_PROFILE##/r /tmp/player_transcoding_profile.tmp" -e "//d" /templates/player_transcoding.tmpl
    cp /templates/player_transcoding.tmpl /usr/local/nginx/html/index.html
else
    RTMPSERVER=nginx-vhost-rtmp-hls
    cp /templates/player.tmpl /usr/local/nginx/html/index.html
fi
sed  "s|##RTMP_SERVER_PORT##|${RTMP_SERVER_PORT}|;s|##RTMP_SERVER_TIMEOUT##|${RTMP_SERVER_TIMEOUT}|;s|##RTMP_SERVER_PING##|${RTMP_SERVER_PING}|;s|##RTMP_SERVER_PING_TIMEOUT##|${RTMP_SERVER_PING_TIMEOUT}|;s|##RTMP_SERVER_MAX_STREAMS##|${RTMP_SERVER_MAX_STREAMS}|;s|##RTMP_SERVER_ACK_WINDOW##|${RTMP_SERVER_ACK_WINDOW}|;s|##RTMP_SERVER_CHUNK_SIZE##|${RTMP_SERVER_CHUNK_SIZE}|;s|##RTMP_SERVER_MAX_MESSAGE##|${RTMP_SERVER_MAX_MESSAGE}|;s|##RTMP_SERVER_BUFLEN##|${RTMP_SERVER_BUFLEN}|;s|##RTMP_SERVER_HLS_FRAGMENT##|${RTMP_SERVER_HLS_FRAGMENT}|;s|##RTMP_SERVER_HLS_PLAYLIST_LENGTH##|${RTMP_SERVER_HLS_PLAYLIST_LENGTH}|;s|##RTMP_SERVER_HLS_SYNC##|${RTMP_SERVER_HLS_SYNC}|;s|##RTMP_SERVER_HLS_CONTINOUS##|${RTMP_SERVER_HLS_CONTINOUS}|;s|##RTMP_SERVER_HLS_NESTED##|${RTMP_SERVER_HLS_NESTED}|;s|##RTMP_SERVER_HLS_CLEANUP##|${RTMP_SERVER_HLS_CLEANUP}|;s|##RTMP_SERVER_HLS_FRAGMENT_NAMING##|${RTMP_SERVER_HLS_FRAGMENT_NAMING}|;s|##RTMP_SERVER_HLS_FRAGMENT_NAMING_GRANULARITY##|${RTMP_SERVER_HLS_FRAGMENT_NAMING_GRANULARITY}|;s|##RTMP_SERVER_HLS_FRAGMENT_SLICING##|${RTMP_SERVER_HLS_FRAGMENT_SLICING}|;s|##RTMP_SERVER_HLS_TYPE##|${RTMP_SERVER_HLS_TYPE}|;s|##RTMP_SERVER_HLS_KEY##|${RTMP_SERVER_HLS_KEY}|;s|##RTMP_SERVER_HLS_FRAGMENTS_PER_KEY##|${RTMP_SERVER_HLS_FRAGMENTS_PER_KEY}|;s|##RTMP_SERVER_HLS_SNAPSHOT_INTERVAL##|${RTMP_SERVER_HLS_SNAPSHOT_INTERVAL}|;s|##HTTP_SERVER_PORT##|${HTTP_SERVER_PORT}|" /templates/$RTMPSERVER.tmpl > /usr/local/nginx/conf/vhost/rtmp/hls.conf

# EXEC NGINX
if [ "${HTTPS_SERVER}" = "true" ]
then
    printf "$(date '+%Y/%m/%d %H:%M:%S') [info] Starting nginx (http: ${HTTP_SERVER_PORT}, https: ${HTTPS_SERVER_PORT}, rtmp: ${RTMP_SERVER_PORT})\n"
else
    printf "$(date '+%Y/%m/%d %H:%M:%S') [info] Starting nginx (http: ${HTTP_SERVER_PORT}, rtmp: ${RTMP_SERVER_PORT})\n"
fi
/usr/local/nginx/sbin/nginx
