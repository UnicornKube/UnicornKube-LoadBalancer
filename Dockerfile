FROM node:lts-buster
ADD https://github.com/just-containers/s6-overlay/releases/download/v2.2.0.1/s6-overlay-amd64-installer /tmp/
RUN chmod +x /tmp/s6-overlay-amd64-installer && /tmp/s6-overlay-amd64-installer /


ARG UNI_LB_RELEASE=https://github.com/UnicornTranscoder/UnicornLoadBalancer/archive/refs/tags/v2.4.3.tar.gz
ENV UNI_LB_RELEASE=${UNI_LB_RELEASE}

ADD ${UNI_LB_RELEASE} /tmp/unicorn-loadbalancer.tar.gz

RUN mkdir -p /tmp/unicorn /unicorn && tar -xvf /tmp/unicorn-loadbalancer.tar.gz -C /tmp/unicorn && cd /tmp/unicorn/* && mv * /unicorn && rm /tmp/unicorn-loadbalancer.tar.gz


COPY root/ /

ENV PLEX_PATH_SESSIONS='/config/Library/Application Support/Plex Media Server/Cache/Transcode/Sessions'
ENV DATABASE_SQLITE_PATH='/config/Library/Application Support/Plex Media Server/Plug-in Support/Databases/com.plexapp.plugins.library.db'


# Init
ENTRYPOINT [ "/init" ]

EXPOSE 3001