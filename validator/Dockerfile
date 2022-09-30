ARG UPSTREAM_VERSION
FROM chainsafe/lodestar:next

RUN apk update && apk add curl jq

#no security parameters in Lodestar currently

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "entrypoint.sh" ]
