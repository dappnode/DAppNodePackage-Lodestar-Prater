#!/bin/sh

# MEV-Boost: https://chainsafe.github.io/lodestar/usage/mev-integration/
if [ -n "$_DAPPNODE_GLOBAL_MEVBOOST_PRATER" ] && [ "$_DAPPNODE_GLOBAL_MEVBOOST_PRATER" == "true" ]; then
    echo "MEV-Boost is enabled"
    EXTRA_OPTS="--builder ${EXTRA_OPTS}"
fi

# Handle Graffiti Character Limit
oLang=$LANG oLcAll=$LC_ALL
LANG=C LC_ALL=C 
graffitiString=${GRAFFITI:0:32}
LANG=$oLang LC_ALL=$oLcAll

exec node /usr/app/node_modules/.bin/lodestar \
    validator \
    --network=goerli \
    --suggestedFeeRecipient=${FEE_RECIPIENT_ADDRESS} \
    --graffiti="${graffitiString}" \
    --dataDir=/var/lib/data \
    --keymanager true \
    --keymanager.authEnabled true \
    --keymanager.port 3500 \
    --keymanager.address 0.0.0.0 \
    --metrics \
    --metrics.port 5064 \
    --metrics.address 0.0.0.0 \
    --externalSigner.url=${HTTP_WEB3SIGNER} \
    --doppelgangerProtection=${DOPPELGANGER_PROTECTION} \
    --beaconNodes=${BEACON_NODE_ADDR} \
    --logLevel=${DEBUG_LEVEL} \
    --logFileLevel=debug \
    --logFileDailyRotate 5 \
    --logFile /var/lib/data/validator.log \
    $EXTRA_OPTS
