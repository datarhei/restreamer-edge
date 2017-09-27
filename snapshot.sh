#!/bin/sh
# ./snapshot.sd {RTMP_PORT} {STREAM_NAME} {INTERVAL}

while true
do
  ffmpeg -i rtmp://127.0.0.1:$1/hls/$2 -vframes 1 -y /usr/local/nginx/html/images/$2.jpg
  sleep $3
done