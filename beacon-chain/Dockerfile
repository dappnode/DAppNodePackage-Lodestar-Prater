ARG UPSTREAM_VERSION
FROM chainsafe/lodestar:next

RUN apt-get update && apt-get curl --yes
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY jwtsecret.hex /jwtsecret

RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE $BEACON_API_PORT

EXPOSE 9000

ENTRYPOINT ["entrypoint.sh"]