#!/usr/bin/env bash
set -euo pipefail
CONF="$HOME/developer/bitcoin-remote/.bitcoin.conf"

TXID="e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163"


raw=$(bitcoin-cli -conf=$CONF getrawtransaction "$TXID")

# mostra todos os possíveis campos (debug)
bitcoin-cli -conf=$CONF decoderawtransaction "$raw" | jq '.vin[0]'

