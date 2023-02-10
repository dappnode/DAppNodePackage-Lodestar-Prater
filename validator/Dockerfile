ARG UPSTREAM_VERSION
FROM chainsafe/lodestar:${UPSTREAM_VERSION}

RUN apk update && apk add curl jq

#Add Authentication Token for External Signer
COPY api-token.txt /var/lib/data/validator-db/api-token.txt
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
