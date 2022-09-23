ARG UPSTREAM_VERSION
FROM chainsafe/lodestar:${UPSTREAM_VERSION}

USER root
RUN apt update && apt install curl --yes
COPY entrypoint.sh entrypoint.sh
COPY jwtsecret.hex /jwtsecret

RUN chmod +x /entrypoint.sh

EXPOSE $BEACON_API_PORT

EXPOSE 9000

ENTRYPOINT ["./entrypoint.sh"]