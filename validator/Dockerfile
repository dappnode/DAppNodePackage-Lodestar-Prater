ARG UPSTREAM_VERSION
FROM chainsafe/lodestar:${UPSTREAM_VERSION}

# curl is required to check if mev-boost is running
RUN apk update && apk add --no-cache curl

COPY api-token.txt /var/lib/data/validator-db/api-token.txt
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
