#!/usr/bin/env bash
set -euo pipefail
CONF="$HOME/developer/bitcoin-remote/.bitcoin.conf"

# 1. coinbase txid do bloco 256128
coinbase=$(bitcoin-cli -conf=$CONF getblock $(bitcoin-cli -conf=$CONF getblockhash 256128) 2 | jq -r '.tx[0].txid')

# 2. todas as txs do bloco 257343
hash257=$(bitcoin-cli -conf=$CONF getblockhash 257343)
bitcoin-cli -conf=$CONF getblock "$hash257" 2 | jq -r --arg cb "$coinbase" '.tx[] | select(.vin[].txid == $cb) | .txid'