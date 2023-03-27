#!/bin/sh

# Concatenate EXTRA_OPTS string
[[ -n "$CHECKPOINT_SYNC_URL" ]] && EXTRA_OPTS="${EXTRA_OPTS} --checkpointSyncUrl=${CHECKPOINT_SYNC_URL}"

case $_DAPPNODE_GLOBAL_EXECUTION_CLIENT_PRATER in
"goerli-geth.dnp.dappnode.eth")
    HTTP_ENGINE="http://goerli-geth.dappnode:8551"
    ;;
"goerli-nethermind.dnp.dappnode.eth")
    HTTP_ENGINE="http://goerli-nethermind.dappnode:8551"
    ;;
"goerli-besu.dnp.dappnode.eth")
    HTTP_ENGINE="http://goerli-besu.dappnode:8551"
    ;;
"goerli-erigon.dnp.dappnode.eth")
    HTTP_ENGINE="http://goerli-erigon.dappnode:8551"
    ;;
*)
    echo "Unknown value for _DAPPNODE_GLOBAL_EXECUTION_CLIENT_PRATER: $_DAPPNODE_GLOBAL_EXECUTION_CLIENT_PRATER"
    HTTP_ENGINE=$_DAPPNODE_GLOBAL_EXECUTION_CLIENT_PRATER
    ;;
esac

# MEV-Boost: https://chainsafe.github.io/lodestar/usage/mev-integration/
if [ -n "$_DAPPNODE_GLOBAL_MEVBOOST_PRATER" ] && [ "$_DAPPNODE_GLOBAL_MEVBOOST_PRATER" == "true" ]; then
    echo "MEV-Boost is enabled"
    MEVBOOST_URL="http://mev-boost.mev-boost-goerli.dappnode:18550"
    if curl --retry 5 --retry-delay 5 --retry-all-errors "${MEVBOOST_URL}"; then
        EXTRA_OPTS="--builder --builder.urls=${MEVBOOST_URL} ${EXTRA_OPTS}"
    else
        echo "MEV-Boost is enabled but the Prater MEV-Boost package at ${MEVBOOST_URL} is not reachable"
        curl -X POST -G 'http://my.dappnode/notification-send' --data-urlencode 'type=danger' --data-urlencode title="${MEVBOOST_URL} can not be reached" --data-urlencode 'body=Make sure the Prater MEV-Boost DNP is available and running'
    fi
fi

# Check the env FEE_RECIPIENT_PRATER has a valid ethereum address if not set to the null address
if [ -n "$FEE_RECIPIENT_PRATER" ] && [[ "$FEE_RECIPIENT_PRATER" =~ ^0x[a-fA-F0-9]{40}$ ]]; then
    FEE_RECIPIENT_ADDRESS="$FEE_RECIPIENT_PRATER"
else
    echo "FEE_RECIPIENT_PRATER is not set or is not a valid ethereum address, setting it to the null address"
    FEE_RECIPIENT_ADDRESS="0x0000000000000000000000000000000000000000"
fi

exec node /usr/app/node_modules/.bin/lodestar \
    beacon \
    --network=goerli \
    --suggestedFeeRecipient=${FEE_RECIPIENT_ADDRESS} \
    --jwt-secret=/jwtsecret \
    --execution.urls=$HTTP_ENGINE \
    --dataDir=/var/lib/data \
    --rest \
    --rest.address 0.0.0.0 \
    --rest.port ${BEACON_API_PORT} \
    --port $P2P_PORT \
    --metrics \
    --metrics.port 8008 \
    --metrics.address 0.0.0.0 \
    --logFile /var/lib/data/beacon.log \
    --logLevel=${DEBUG_LEVEL} \
    --logFileLevel=debug \
    --logFileDailyRotate 5 \
    $EXTRA_OPTS
