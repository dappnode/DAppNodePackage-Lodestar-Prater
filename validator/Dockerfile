ARG UPSTREAM_VERSION
FROM chainsafe/lodestar:next

RUN apk update && apk curl jq --yes

#no security parameters in Lodestar currently

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "entrypoint.sh" ]
