FROM node:lts-buster
ADD https://github.com/just-containers/s6-overlay/releases/download/v2.2.0.1/s6-overlay-amd64-installer /tmp/
RUN chmod +x /tmp/s6-overlay-amd64-installer && /tmp/s6-overlay-amd64-installer /


ARG UNI_LB_RELEASE=https://github.com/UnicornTranscoder/UnicornLoadBalancer/archive/refs/tags/v2.4.3.tar.gz
ENV UNI_LB_RELEASE=${UNI_LB_RELEASE}

ADD ${UNI_LB_RELEASE} /tmp/unicorn-loadbalancer.tar.gz

RUN mkdir -p /tmp/unicorn /unicorn && tar -xvf /tmp/unicorn-loadbalancer.tar.gz -C /tmp/unicorn && cd /tmp/unicorn/* && mv * /unicorn && cd /unicorn && npm i

# Init
ENTRYPOINT [ "/init" ]

CMD [ "sh", "-c", "cd /unicorn; npm run start" ]
