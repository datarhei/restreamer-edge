# Restreamer-Edge

This is an stable working concept to create a streaming service in front of the [Datarhei/Restreamer](https://github.com/datarhei/restreamer).

![restreamer-edge](docs/idea.png)

Currently the Restreamer-Edge is very plain and bash based application without user-interface and administration. It's an experiment to learn more about this setup of applications. Do not no worry about "concept" and "very plain". It is tested over weeks and ready to run on your server or an cloud-space! It works stable like charm :-)

* [Docker startup](#docker-startup)
* [Enviroment playground](#enviroment-playground)
* [Enviroment variables](#enviroment-variables)
* [Hosting examples](#hosting-examples)
* [Optimizations / Tips](#optimizations--tips)
* [Help, bugs and future requests](#help-bugs-and-future-requests)

## Features

* [NGINX](http://nginx.org/) open source web server for high traffic
* [NGINX-RTMP-Module](https://github.com/arut/nginx-rtmp-module) as streaming-backend and HLS server
* [NGINX Stub Status](https://github.com/mhowlett/ngx_stub_status_prometheus) for Prometheus.io
* [NGINX Metrics](https://github.com/knyar/nginx-lua-prometheus) for Prometheus.io
* [NJS](https://github.com/nginx/njs) for the rtmp-authentification
* [Clappr-Player](https://github.com/clappr/clappr) as HLS-player to embed your stream upon your website (no Adobe Flash)
* [FFmpeg](http://ffmpeg.org) to create snapshots and live-transcode (if enabled) each is pushing streams to 240p, 360p, 480p and 720p
* [Let's Encrypt](https://github.com/letsencrypt/letsencrypt) to secure NGINX by a verified certificate

## Docker startup

#### Default:

```sh
docker run -d --name restreamer-edge --restart always -p 80:80 -p 1935:1935 \
  -e "HTTP_AUTH_USERNAME=your-username" \
  -e "HTTP_AUTH_PASSWORD=your-password" \
  -e "RTMP_PUBLISH_TOKEN=your-secure-token" \
      datarhei/restreamer-edge:latest
```

*Please use "datarhei/restreamer-edge-armhf:latest" for ARMv6/7 and "datarhei/restreamer-edge-aarch64:latest" for Aarch64*

##### Optionally you can use an enviroment file ([file example](edge.env)):

```sh
docker run -d --name restreamer-edge --restart always -p 80:80 -p 1935:1935 \
    --env-file $PWD/edge.env \
      datarhei/restreamer-edge:latest
```

## Enviroment playground

#### 4 CPU-Threads, 4096 connections per worker:

```sh
  -e "WORKER_PROCESSES=4" 
  -e "WORKER_CONNECTIONS=4096"
```

#### Live-Transcoding 240p/720p:

```sh
  -e "RTMP_SRV_APP_HLS_TRANSCODING=true" 
  -e "RTMP_SRV_APP_HLS_TRANSCODING_PROFILES=240p,720p" 
```

Available profiles are: 240p, 360p, 480p, 720p and native   
*Trancoding requires high CPU power for each pushed stream!*

#### 5 hours DvR like playlist:

```sh
  -e "RTMP_SRV_APP_HLS_HLS_PLAYLIST_LENGTH=18000" 
```

#### Enable Access-Log and send it to STDOUT:

```sh
  -e "HTTP_ACCESS_LOG=/dev/stdout" 
```

#### Enable HTTPS/SSL and Let's Encrypt:

```sh
  -e "HTTPS_SRV=true" 
  -e "HTTPS_SRV_CERT_DOMAIN=example.org,example.com" 
  -e "HTTPS_LETSENCRYPT=true"
  -e "HTTPS_LETSENCRYPT_MAIL=admin@example.org"
  -p 443:443
  -v /mnt/restreamer-edge/letsencrypt:/etc/letsencrypt
```

*Port 80/443 have to be forwarded to the Restreamer-Edge and the destination of your Domains have to be your host IP-Address!* 

##### To auto renew your Let's Encrypt certificat you can use cron/systemd like:

```sh
  0 0 * * * /usr/bin/docker restart restreamer-edge >/dev/null 2>&1
```

#### Customize your Player

```sh
  -e "PLAYER_WATERMARK_SOURCE=http://datarhei.org/logo.png" 
  -e "PLAYER_WATERMARK_POSITION=top-left" 
  -e "PLAYER_WATERMARK_LINK=http://datarhei.org" 
  -e "PLAYER_COLOR_BUTTONS=000000" 
  -e "PLAYER_COLOR_SEEKBAR=000000"
  -e "PLAYER_GA_ACCOUNT=UE123456"
  -e "PLAYER_GA_TRACKERNAME=datarheiDemoEdge1"
```

## Usage

#### Pushing a stream to the Resteamer-Edge:

1. add the RTMP-URL to the "External RTMP-Streaming-Server" selection of your Restreamer:   
   rtmp://[your-edge-ip]:[rtmp-port]/hls/mystream?token=[your-token]
2. open the Edge-Player on your browser:   
   http://[your-edge-ip]:[http-port]/index.html?stream=mystream

#### NGINX-Exporter for Prometheus.io:

1. Open stauts page:  
   http://[your-edge-ip]:[http-port]/status   
2. Enter your login data is set by:  
  ```-e HTTP_AUTH_USERNAME=your-username```   
  ```-e HTTP_AUTH_PASSWORD=your-password```

1. Open metrics page:  
   http://[your-edge-ip]:[http-port]/metrics   
2. Enter your login data is set by:  
  ```-e HTTP_AUTH_USERNAME=your-username```   
  ```-e HTTP_AUTH_PASSWORD=your-password```

#### RTMP stat

1. Open "http://[your-edge-ip]:[http-port]/rtmp-stat"
2. Enter your login data is set by:  
  ```-e HTTP_AUTH_USERNAME=your-username```   
  ```-e HTTP_AUTH_PASSWORD=your-password```
  
*Alternative "http://[your-edge-ip]:[http-port]/rtmp-stat.xml" or "http://[your-edge-ip]:[http-port]/rtmp-stat.json"*

## Enviroment variables

#### Descriptions

* NGINX [description](http://nginx.org/en/docs/ngx_core_module.html)
* NGINX RTMP [description](https://github.com/sergey-dryabzhinsky/nginx-rtmp-module/blob/master/doc/directives.md)
* Clappr-Player [description](https://github.com/clappr/clappr/blob/master/doc/BUILTIN_PLUGINS.md)

#### Default values

```sh
WORKER_PROCESSES "1"
WORKER_CONNECTIONS "1024"

RTMP_ACCESS_LOG "off"

RTMP_SRV_PORT "1935"
RTMP_SRV_TIMEOUT "60s"
RTMP_SRV_PING "3m"
RTMP_SRV_PING_TIMEOUT "30s"
RTMP_SRV_MAX_STREAMS "32"
RTMP_SRV_ACK_WINDOW "5000000"
RTMP_SRV_CHUNK_SIZE "4096"
RTMP_SRV_MAX_MESSAGE "1M"
RTMP_SRV_BUFLEN "5s"

RTMP_SRV_APP_HLS_INTERLEAVE "on"
RTMP_SRV_APP_HLS_META "copy"
RTMP_SRV_APP_HLS_WAIT_KEY "on"
RTMP_SRV_APP_HLS_WAIT_VIDEO "on"
RTMP_SRV_APP_HLS_DROP_IDLE_PUBLISHER "10s"
RTMP_SRV_APP_HLS_SYNC "10ms"
RTMP_SRV_APP_HLS_IDLE_STREAMS "off"

RTMP_SRV_APP_HLS_HLS_FRAGMENT "2s"
RTMP_SRV_APP_HLS_HLS_PLAYLIST_LENGTH "60"
RTMP_SRV_APP_HLS_HLS_SYNC "1ms"
RTMP_SRV_APP_HLS_HLS_CONTINOUS "off"
RTMP_SRV_APP_HLS_HLS_NESTED "off"
RTMP_SRV_APP_HLS_HLS_CLEANUP "on"
RTMP_SRV_APP_HLS_HLS_FRAGMENT_NAMING "sequential"
RTMP_SRV_APP_HLS_HLS_FRAGMENT_NAMING_GRANULARITY "0"
RTMP_SRV_APP_HLS_HLS_FRAGMENT_SLICING "plain"
RTMP_SRV_APP_HLS_HLS_TYPE "live"
RTMP_SRV_APP_HLS_HLS_KEY "off"
RTMP_SRV_APP_HLS_HLS_FRAGMENTS_PER_KEY "0"

RTMP_SRV_APP_HLS_SNAPSHOT_INTERVAL "60"
RTMP_SRV_APP_HLS_TRANSCODING "false"
RTMP_SRV_APP_HLS_TRANSCODING_PROFILES "240p,360p,480p,720p,native"

RTMP_PUBLISH_TOKEN "datarhei"

HTTP_SENDFILE "on"
HTTP_TCP_NOPUSH "on"
HTTP_TCP_NODELAY "on"
HTTP_ACCESS_LOG "off"

HTTP_SRV_PORT "80"
HTTP_SRV_LOC_HLS_ACCESS_CONTROL_ALLOW_ORIGIN "*"

HTTP_AUTH_USERNAME "admin"
HTTP_AUTH_PASSWORD "datarhei"

HTTPS_SRV "false"
HTTPS_SRV_PORT "443"
HTTPS_SRV_CERT_DOMAIN "example.org"

HTTPS_LETSENCRYPT "false"
HTTPS_LETSENCRYPT_MAIL "admin@example.org"

PLAYER_CREATE "true"

PLAYER_WATERMARK_SOURCE "none"
PLAYER_WATERMARK_POSITION "top-right"
PLAYER_WATERMARK_LINK "none"

PLAYER_COLOR_BUTTONS "3daa48"
PLAYER_COLOR_SEEKBAR "3daa48"

PLAYER_GA_ACCOUNT "none"
PLAYER_GA_TRACKERNAME "datarheiEdge"
```

## Hosting examples

* [DigitalOcean](#digitalocean)
* [Scaleway](#scaleway)
* [Mesosphere Marathon (DCOS)](#mesosphere-marathon-dcos)

#### [DigitalOcean](https://www.digitalocean.com/)

1. Create a Droplet based on CoreOS and insert the following content into the "User Data" field:
```sh
#cloud-config
write_files:
  - path: /etc/restreamer-edge.env
    content: |
      RTMP_SRV_APP_HLS_PUBLISH_TOKEN=datarhei
      HTTP_AUTH_USERNAME=admin
      HTTP_AUTH_PASSWORD=datarhei
coreos:
  units:
    - name: restreamer-edge.service
      command: start
      content: |
        [Unit]
        Description=restreamer-edge
        After=docker.service
        Requires=docker.service
        [Service]
        TimeoutStartSec=0
        ExecStartPre=-/usr/bin/docker kill restreamer-edge
        ExecStartPre=-/usr/bin/docker rm restreamer-edge
        ExecStartPre=/usr/bin/docker pull datarhei/restreamer-edge:latest
        ExecStart=/usr/bin/docker run --name restreamer-edge -p 80:80 -p 1935:1935 --env-file /etc/restreamer-edge.env datarhei/restreamer-edge:latest
        ExecStop=/usr/bin/docker stop restreamer-edge
        ExecReload=/usr/bin/docker restart restreamer-edge
```

2. wait few minutes, then you can push a stream to "rtmp://[your-droplet-ip]:1935/hls/mystream?token=datarhei" and can open the Player/Stream "http://[your-droplet-ip]:80/?stream=mystream"

*Hint: Please use your own auth. data^^*

#### [Scaleway](https://scaleway.com)

1. Click "create server"
2. Select "Docker" on the Imagehub as OS
3. Launch your new server
4. Login and start the edge:   
   * for an ARM instance:   
```sh 
docker run -d --name restreamer-edge --restart always -p 80:80 -p 1935:1935 \
  -e "HTTP_AUTH_USERNAME=admin" \
  -e "HTTP_AUTH_PASSWORD=datarhei" \
  -e "RTMP_PUBLISH_TOKEN=datarhei" \
      datarhei/restreamer-edge-armhf:latest
```
   * For an x86 instance:   
```sh
docker run -d --name restreamer-edge --restart always -p 80:80 -p 1935:1935 \
  -e "HTTP_AUTH_USERNAME=admin" \
  -e "HTTP_AUTH_PASSWORD=datarhei" \
  -e "RTMP_PUBLISH_TOKEN=datarhei" \
      datarhei/restreamer-edge:latest
```
5. Wait few minutes, then you can push the stream to "rtmp://[your-server-ip]:1935/hls/mystream?token=datarhei". Open the Player/Stream "http://[your-server-ip]:80/?stream=mystream"


*Hint: Please use your own auth. data^^*

#### [Mesosphere Marathon](https://github.com/mesosphere/marathon) ([DCOS](https://mesosphere.com/product/))

1. Startup your DCOS cloud or Marathon instance
2. Post the following config to Marathon (replace "marathon-ip")
```sh
curl -X POST -H "Accept: application/json" -H "Content-Type: application/json" marathon-ip:8080/v2/apps -d '{
	"id": "/datarhei/restreamer-edge",
	"container": {
		"type": "DOCKER",
		"docker": {
			"image": "datarhei/restreamer-edge:latest",
			"network": "BRIDGE",
			"portMappings": [{
				"containerPort": 80,
				"hostPort": 0,
				"protocol": "tcp"
			}, {
				"containerPort": 1935,
				"hostPort": 0,
				"protocol": "tcp"
			}]
		},
		"volumes": []
	},
	"env": {
		"RTMP_PUBLISH_TOKEN": "datarhei",
		"HTTP_AUTH_USERNAME": "admin",
		"HTTP_AUTH_PASSWORD": "datarhei"
	},
	"cpus": 1,
	"mem": 1024,
	"instances": 1,
	"healthChecks": [{
		"portIndex": 1,
		"protocol": "HTTP",
		"path": "/",
		"gracePeriodSeconds": 3,
		"intervalSeconds": 10,
		"timeoutSeconds": 10,
		"maxConsecutiveFailures": 3
	}]
}'
```

3. Wait few minutes, then you are able to push a stream to "rtmp://[mesos-agent-ip]:[port1]/hls/mystream?token=datarhei". Open the Player/Stream "http://[mesos-agent-ip]:[port0]/?stream=mystream"

*Hint: Please use your own auth. data^^*

## Optimizations / Tips

1. reduce the network latency   
   ```sh
   replace "-p PORT:PORT" by
   $ docker run ... --net=host ...
   ```

2. reduce the I/O by a RAM-Disk (268M is just a example)  
   ```sh
   $ mount -t tmpfs -o size=268M none /mnt/restreamer-edge/hls
   $ docker run .... -v /mnt/restreamer-edge/hls:/tmp/hls ....
   ```

## Build your own Image

```sh
docker build -t restreamer-edge:amd64 \
              --build-arg FFMPEG_IMAGE=datarhei/ffmpeg:3 \
              --build-arg ALPINE_IMAGE=alpine:latest . 
             
docker build -t restreamer-edge:armhf \
              --build-arg FFMPEG_IMAGE=datarhei/ffmpeg:3-armhf \
              --build-arg ALPINE_IMAGE=resin/armhf-alpine:latest . 
             
docker build -t restreamer-edge:aarch64 \
              --build-arg FFMPEG_IMAGE=datarhei/ffmpeg:3-aarch64 \
              --build-arg ALPINE_IMAGE=resin/aarch64-alpine:latest .
```

## Help, bugs and future requests

If you have problems or found a bug feel free to create a new issue on the Github issue management.

Need personal help or want to talk to us? Write email open@datarhei.org or choose a nickname and join us on #datarhei webchat on freenode.

If you are an expert and have better settings, good ideas for extensions or guides for something else you are very welcome to write an issue, create a pull-request or contact us by sending an email or joining on IRC. We are happy about every expert who want to improve our ideas! 

## Copyright

Code released under the Apache license. Images are copyrighted by datarhei.org
