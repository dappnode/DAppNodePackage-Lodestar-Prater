ARG UPSTREAM_VERSION
FROM chainsafe/lodestar:${UPSTREAM_VERSION}

# curl is required to check if mev-boost is running
RUN apk update && apk add --no-cache curl

COPY jwtsecret.hex /jwtsecret
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

EXPOSE $BEACON_API_PORT

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
