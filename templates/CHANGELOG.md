Changes from v0.1.0-rc.1 to v0.1.0-rc.2

* removed AIO (was problematic)
* optimized snapshot creation
* added Let's Encrypt
* added "native" trancoding profile
* modified (default) env:
  * MOD: RTMP_SERVER_HLS_TRANSCODING_PROFILE + "native"
  * MOD: HTTP_SENDFILE "on" 
  * NEW: HTTP_TCP_NODELAY "on"
  * NEW: HTTPS_SERVER "off"
  * NEW: HTTPS_SERVER_PORT "443"
  * NEW: HTTPS_CERT_MAIL ""
  * NEW: HTTPS_CERT_DOMAIN ""
  * REMOVED: HTTP_AIO
  * REMOVED: HTTP_DIRECTIO
