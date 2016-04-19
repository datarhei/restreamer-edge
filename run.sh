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
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SRV_PORT ${RTMP_SRV_PORT}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SRV_TIMEOUT ${RTMP_SRV_TIMEOUT}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SRV_PING ${RTMP_SRV_PING}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SRV_PING_TIMEOUT ${RTMP_SRV_PING_TIMEOUT}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SRV_MAX_STREAMS ${RTMP_SRV_MAX_STREAMS}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SRV_ACK_WINDOW ${RTMP_SRV_ACK_WINDOW}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SRV_CHUNK_SIZE ${RTMP_SRV_CHUNK_SIZE}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SRV_MAX_MESSAGE ${RTMP_SRV_MAX_MESSAGE}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SRV_BUFLEN ${RTMP_SRV_BUFLEN}\n"

printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SRV_APP_HLS_INTERLEAVE ${RTMP_SRV_APP_HLS_INTERLEAVE}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SRV_APP_HLS_META ${RTMP_SRV_APP_HLS_META}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SRV_APP_HLS_WAIT_KEY ${RTMP_SRV_APP_HLS_WAIT_KEY}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SRV_APP_HLS_WAIT_VIDEO ${RTMP_SRV_APP_HLS_WAIT_VIDEO}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SRV_APP_HLS_DROP_IDLE_PUBLISHER ${RTMP_SRV_APP_HLS_DROP_IDLE_PUBLISHER}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SRV_APP_HLS_SYNC ${RTMP_SRV_APP_HLS_SYNC}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SRV_APP_HLS_IDLE_STREAMS ${RTMP_SRV_APP_HLS_IDLE_STREAMS}\n"

printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SRV_APP_HLS_HLS_FRAGMENT ${RTMP_SRV_APP_HLS_HLS_FRAGMENT}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SRV_APP_HLS_HLS_PLAYLIST_LENGTH ${RTMP_SRV_APP_HLS_HLS_PLAYLIST_LENGTH}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SRV_APP_HLS_HLS_SYNC ${RTMP_SRV_APP_HLS_HLS_SYNC}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SRV_APP_HLS_HLS_CONTINOUS ${RTMP_SRV_APP_HLS_HLS_CONTINOUS}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SRV_APP_HLS_HLS_NESTED ${RTMP_SRV_APP_HLS_HLS_NESTED}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SRV_APP_HLS_HLS_CLEANUP ${RTMP_SRV_APP_HLS_HLS_CLEANUP}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SRV_APP_HLS_HLS_FRAGMENT_NAMING ${RTMP_SRV_APP_HLS_HLS_FRAGMENT_NAMING}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SRV_APP_HLS_HLS_FRAGMENT_NAMING_GRANULARITY ${RTMP_SRV_APP_HLS_HLS_FRAGMENT_NAMING_GRANULARITY}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SRV_APP_HLS_HLS_FRAGMENT_SLICING ${RTMP_SRV_APP_HLS_HLS_FRAGMENT_SLICING}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SRV_APP_HLS_HLS_TYPE ${RTMP_SRV_APP_HLS_HLS_TYPE}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SRV_APP_HLS_HLS_KEY ${RTMP_SRV_APP_HLS_HLS_KEY}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SRV_APP_HLS_HLS_FRAGMENTS_PER_KEY ${RTMP_SRV_APP_HLS_HLS_FRAGMENTS_PER_KEY}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SRV_APP_HLS_SNAPSHOT_INTERVAL ${RTMP_SRV_APP_HLS_SNAPSHOT_INTERVAL}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SRV_APP_HLS_TRANSCODING ${RTMP_SRV_APP_HLS_TRANSCODING}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_SRV_APP_HLS_TRANSCODING_PROFILES ${RTMP_SRV_APP_HLS_TRANSCODING_PROFILES}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV RTMP_PUBLISH_TOKEN ${RTMP_PUBLISH_TOKEN}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV HTTP_SENDFILE ${HTTP_SENDFILE}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV HTTP_TCP_NOPUSH ${HTTP_TCP_NOPUSH}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV HTTP_TCP_NODELAY ${HTTP_TCP_NODELAY}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV HTTP_ACCESS_LOG ${HTTP_ACCESS_LOG}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV HTTP_SRV_PORT ${HTTP_SRV_PORT}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV HTTP_SRV_LOC_HLS_ACCESS_CONTROL_ALLOW_ORIGIN ${HTTP_SRV_LOC_HLS_ACCESS_CONTROL_ALLOW_ORIGIN}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV HTTPS_SRV ${HTTPS_SRV}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV HTTPS_SRV_PORT ${HTTPS_SRV_PORT}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV HTTPS_CERT_CREATE ${HTTPS_CERT_CREATE}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV HTTPS_CERT_MAIL ${HTTPS_CERT_MAIL}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] ENV HTTPS_CERT_DOMAIN ${HTTPS_CERT_DOMAIN}\n"
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] \n"

# CREATE BASIC AUTH
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] " && htpasswd -bc /usr/local/nginx/conf/auth.htpasswd ${HTTP_AUTH_USERNAME} ${HTTP_AUTH_PASSWORD}
printf "\n"

# CREATE SSL CERTS
if [ "${HTTPS_SRV}" = "true" ] && [ "${HTTPS_CERT_CREATE}" = "true" ]
then
    DOMAINS=$(echo ${HTTPS_CERT_DOMAIN} | sed 's/,/ -d /g')
    /opt/letsencrypt/letsencrypt-auto certonly --no-self-upgrade --renew-by-default --agree-tos --email ${HTTPS_CERT_MAIL} -d ${DOMAINS}
fi

# CREATE NGINX.CONF
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] Creating nginx.conf\n"
sed  "s|##WORKER_PROCESSES##|${WORKER_PROCESSES}|;s|##WORKER_CONNECTIONS##|${WORKER_CONNECTIONS}|;s|##RTMP_AUTO_PUSH##|${RTMP_AUTO_PUSH}|;s|##HTTP_SENDFILE##|${HTTP_SENDFILE}|;s|##HTTP_TCP_NOPUSH##|${HTTP_TCP_NOPUSH}|;s|##HTTP_TCP_NODELAY##|${HTTP_TCP_NODELAY}|;s|##RTMP_ACCESS_LOG##|${RTMP_ACCESS_LOG}|;s|##HTTP_ACCESS_LOG##|${HTTP_ACCESS_LOG}|" /templates/nginx.tmpl > /usr/local/nginx/conf/nginx.conf

# CREATE VHOST WWW HTTP
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] Creating www/http vhost\n"
sed  "s|##HTTP_SRV_PORT##|${HTTP_SRV_PORT}|;s|##RTMP_PUBLISH_TOKEN##|${RTMP_PUBLISH_TOKEN}|;s|##HTTP_SRV_LOC_HLS_ACCESS_CONTROL_ALLOW_ORIGIN##|${HTTP_SRV_LOC_HLS_ACCESS_CONTROL_ALLOW_ORIGIN}|" /templates/nginx-vhost-www-http.tmpl > /usr/local/nginx/conf/vhost/www/http.conf

# CREATE VHOST WWW HTTPS
if [ "${HTTPS_SRV}" = "true" ]
then
    CERT_NAME=$(echo ${HTTPS_CERT_DOMAIN} | cut -d ',' -f1)
    printf "$(date '+%Y/%m/%d %H:%M:%S') [info] Creating www/https vhost\n"
    sed  "s|##HTTPS_SRV_PORT##|${HTTPS_SRV_PORT}|;s|##CERT_NAME##|${CERT_NAME}|;s|##RTMP_PUBLISH_TOKEN##|${RTMP_PUBLISH_TOKEN}|;s|##HTTP_SRV_LOC_HLS_ACCESS_CONTROL_ALLOW_ORIGIN##|${HTTP_SRV_LOC_HLS_ACCESS_CONTROL_ALLOW_ORIGIN}|" /templates/nginx-vhost-www-https.tmpl > /usr/local/nginx/conf/vhost/www/https.conf
fi

# CREATE VHOST RTMP HLS
printf "$(date '+%Y/%m/%d %H:%M:%S') [info] Creating rtmp/hls vhost\n"
if [ ${RTMP_SRV_APP_HLS_TRANSCODING} = "true" ]
then
    RTMPSRV=nginx-vhost-rtmp-hls-transcoding
    PROFILES=$(echo $RTMP_SRV_APP_HLS_TRANSCODING_PROFILES | sed 's/,/ /g')
    
    # ADD FFMPEG COMMAND
    FFMPEG_COMMAND=$(cd /templates/ffmpeg_profiles && cat $PROFILES)
    echo $FFMPEG_COMMAND > /tmp/ffmpeg_command.tmp
    sed -i -e "/##FFMPEG_COMMAND##/r /tmp/ffmpeg_command.tmp" -e "//d" /templates/$RTMPSRV.tmpl
    sed -i "s/##RTMP_SRV_PORT##/${RTMP_SRV_PORT}/g" /templates/$RTMPSRV.tmpl
    
    # ADD HLS VARIANT
    i=0
    for profile in $PROFILES
    do
       PROFILE_CONTENT=$(cat /templates/hls_variant/"$profile")
       printf "$PROFILE_CONTENT\n" >> /tmp/hls_variant.tmp
    done
    sed -i '1!G;h;$!d' /tmp/hls_variant.tmp
    sed -i -e "/##HLS_VARIANT##/r /tmp/hls_variant.tmp" -e "//d" /templates/$RTMPSRV.tmpl
    
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
    RTMPSRV=nginx-vhost-rtmp-hls
    cp /templates/player.tmpl /usr/local/nginx/html/index.html
fi
sed  "s|##RTMP_SRV_PORT##|${RTMP_SRV_PORT}|;s|##RTMP_SRV_TIMEOUT##|${RTMP_SRV_TIMEOUT}|;s|##RTMP_SRV_PING##|${RTMP_SRV_PING}|;s|##RTMP_SRV_PING_TIMEOUT##|${RTMP_SRV_PING_TIMEOUT}|;s|##RTMP_SRV_MAX_STREAMS##|${RTMP_SRV_MAX_STREAMS}|;s|##RTMP_SRV_ACK_WINDOW##|${RTMP_SRV_ACK_WINDOW}|;s|##RTMP_SRV_CHUNK_SIZE##|${RTMP_SRV_CHUNK_SIZE}|;s|##RTMP_SRV_MAX_MESSAGE##|${RTMP_SRV_MAX_MESSAGE}|;s|##RTMP_SRV_BUFLEN##|${RTMP_SRV_BUFLEN}|;s|##RTMP_SRV_APP_HLS_INTERLEAVE##|${RTMP_SRV_APP_HLS_INTERLEAVE}|;s|##RTMP_SRV_APP_HLS_META##|${RTMP_SRV_APP_HLS_META}|;s|##RTMP_SRV_APP_HLS_WAIT_KEY##|${RTMP_SRV_APP_HLS_WAIT_KEY}|;s|##RTMP_SRV_APP_HLS_WAIT_VIDEO##|${RTMP_SRV_APP_HLS_WAIT_VIDEO}|;s|##RTMP_SRV_APP_HLS_DROP_IDLE_PUBLISHER##|${RTMP_SRV_APP_HLS_DROP_IDLE_PUBLISHER}|;s|##RTMP_SRV_APP_HLS_SYNC##|${RTMP_SRV_APP_HLS_SYNC}|;s|##RTMP_SRV_APP_HLS_IDLE_STREAMS##|${RTMP_SRV_APP_HLS_IDLE_STREAMS}|;s|##RTMP_SRV_APP_HLS_HLS_FRAGMENT##|${RTMP_SRV_APP_HLS_HLS_FRAGMENT}|;s|##RTMP_SRV_APP_HLS_HLS_PLAYLIST_LENGTH##|${RTMP_SRV_APP_HLS_HLS_PLAYLIST_LENGTH}|;s|##RTMP_SRV_APP_HLS_HLS_SYNC##|${RTMP_SRV_APP_HLS_HLS_SYNC}|;s|##RTMP_SRV_APP_HLS_HLS_CONTINOUS##|${RTMP_SRV_APP_HLS_HLS_CONTINOUS}|;s|##RTMP_SRV_APP_HLS_HLS_NESTED##|${RTMP_SRV_APP_HLS_HLS_NESTED}|;s|##RTMP_SRV_APP_HLS_HLS_CLEANUP##|${RTMP_SRV_APP_HLS_HLS_CLEANUP}|;s|##RTMP_SRV_APP_HLS_HLS_FRAGMENT_NAMING##|${RTMP_SRV_APP_HLS_HLS_FRAGMENT_NAMING}|;s|##RTMP_SRV_APP_HLS_HLS_FRAGMENT_NAMING_GRANULARITY##|${RTMP_SRV_APP_HLS_HLS_FRAGMENT_NAMING_GRANULARITY}|;s|##RTMP_SRV_APP_HLS_HLS_FRAGMENT_SLICING##|${RTMP_SRV_APP_HLS_HLS_FRAGMENT_SLICING}|;s|##RTMP_SRV_APP_HLS_HLS_TYPE##|${RTMP_SRV_APP_HLS_HLS_TYPE}|;s|##RTMP_SRV_APP_HLS_HLS_KEY##|${RTMP_SRV_APP_HLS_HLS_KEY}|;s|##RTMP_SRV_APP_HLS_HLS_FRAGMENTS_PER_KEY##|${RTMP_SRV_APP_HLS_HLS_FRAGMENTS_PER_KEY}|;s|##RTMP_SRV_APP_HLS_SNAPSHOT_INTERVAL##|${RTMP_SRV_APP_HLS_SNAPSHOT_INTERVAL}|;s|##HTTP_SRV_PORT##|${HTTP_SRV_PORT}|" /templates/$RTMPSRV.tmpl > /usr/local/nginx/conf/vhost/rtmp/hls.conf

# EXEC NGINX
if [ "${HTTPS_SRV}" = "true" ]
then
    printf "$(date '+%Y/%m/%d %H:%M:%S') [info] Starting nginx (http: ${HTTP_SRV_PORT}, https: ${HTTPS_SRV_PORT}, rtmp: ${RTMP_SRV_PORT})\n"
else
    printf "$(date '+%Y/%m/%d %H:%M:%S') [info] Starting nginx (http: ${HTTP_SRV_PORT}, rtmp: ${RTMP_SRV_PORT})\n"
fi
/usr/local/nginx/sbin/nginx
