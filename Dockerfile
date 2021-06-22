FROM node:lts-buster
ADD https://github.com/just-containers/s6-overlay/releases/download/v2.2.0.1/s6-overlay-amd64-installer /tmp/
RUN chmod +x /tmp/s6-overlay-amd64-installer && /tmp/s6-overlay-amd64-installer /


ARG UNI_LB_RELEASE=https://github.com/UnicornTranscoder/UnicornLoadBalancer/archive/refs/tags/v2.4.3.tar.gz
ENV UNI_LB_RELEASE=${UNI_LB_RELEASE}

ADD ${UNI_LB_RELEASE} /tmp/unicorn-loadbalancer.tar.gz

RUN mkdir -p /tmp/unicorn /unicorn && tar -xvf /tmp/unicorn-loadbalancer.tar.gz -C /tmp/unicorn && cd /tmp/unicorn/* && mv * /unicorn && rm /tmp/unicorn-loadbalancer.tar.gz


COPY root/ /

ENV SERVER_PORT=3001
ENV SERVER_PUBLIC=http://127.0.0.1:3001/
ENV PLEX_HOST=127.0.0.1
ENV PLEX_PORT=32400
#ENV PLEX_PATH_USR=/usr/lib/plexmediaserver/
ENV PLEX_PATH_SESSIONS='/config/Library/Application Support/Plex Media Server/Cache/Transcode/Sessions'
ENV DATABASE_MODE=sqlite
ENV DATABASE_SQLITE_PATH='/config/Library/Application Support/Plex Media Server/Plug-in Support/Databases/com.plexapp.plugins.library.db'
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


# Init
ENTRYPOINT [ "/init" ]
CMD [ "sh", "-c", "cd /unicorn; npm run start" ]

EXPOSE 3001