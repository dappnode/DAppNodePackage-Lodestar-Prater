ARG UPSTREAM_VERSION
FROM chainsafe/lodestar:${UPSTREAM_VERSION}

RUN apt-get update && apt-get curl jq --yes
# need Lion's help here
#COPY security/
#COPY security/

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "entrypoint.sh" ]
