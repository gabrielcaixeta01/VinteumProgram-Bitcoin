#!/usr/bin/env bash
set -euo pipefail
CONF="$HOME/developer/bitcoin-remote/.bitcoin.conf"

hash=$(bitcoin-cli -conf=$CONF getblockhash 444431)
bitcoin-cli -conf=$CONF getblock "$hash" 2 | jq -r '.tx[] | select([.vin[].sequence] | any(. < 4294967294)) | .txid'