FROM node:lts-alpine

ENV SERVER_PORT=3001
ENV SERVER_PUBLIC=http://127.0.0.1:3001/
ENV PLEX_HOST=127.0.0.1
ENV PLEX_PORT=32400
ENV PLEX_PATH_USR=/usr/lib/plexmediaserver/
ENV PLEX_PATH_SESSIONS='/var/lib/plexmediaserver/Library/Application Support/Plex Media Server/Cache/Transcode/Sessions'
ENV DATABASE_MODE=sqlite
ENV DATABASE_SQLITE_PATH='/var/lib/plexmediaserver/Library/Application Support/Plex Media Server/Plug-in Support/Databases/com.plexapp.plugins.library.db'
ENV DATABASE_POSTGRESQL_HOST=
ENV DATABASE_POSTGRESQL_DATABASE=
ENV DATABASE_POSTGRESQL_USER=
ENV DATABASE_POSTGRESQL_PASSWORD=
ENV DATABASE_POSTGRESQL_PORT=5432
ENV REDIS_HOST=undefined
ENV REDIS_PORT=6379
ENV REDIS_PASSWORD=
ENV REDIS_DB=0
ENV CUSTOM_SCORES_TIMEOUT=10
ENV CUSTOM_IMAGE_PROXY=
ENV CUSTOM_DOWNLOAD_FORWARD=false
ENV CUSTOM_SERVERS_LIST=[]

ENV LB_VERSION=2.4.3

RUN wget https://github.com/UnicornTranscoder/UnicornLoadBalancer/archive/refs/tags/v$LB_VERSION.zip && unzip v$LB_VERSION.zip && mv UnicornLoadBalancer-$LB_VERSION UnicornLoadBalancer && rm v$LB_VERSION.zip

WORKDIR /UnicornLoadBalancer

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "entrypoint.sh" ]