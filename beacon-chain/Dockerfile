ARG UPSTREAM_VERSION
FROM chainsafe/lodestar:${UPSTREAM_VERSION}

USER root
RUN apk update && apk add curl
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY jwtsecret.hex /jwtsecret

RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE $BEACON_API_PORT

EXPOSE 9000

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
