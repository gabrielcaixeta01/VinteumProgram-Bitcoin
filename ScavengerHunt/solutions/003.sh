#!/usr/bin/env bash
set -euo pipefail

# pasta onde o script está
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# bitcoin.conf fica em ../.config relativo à pasta solutions/
CONF="${CONF:-$DIR/../.config/bitcoin.conf}"

hash=$(bitcoin-cli -conf=$CONF getblockhash 123456)
bitcoin-cli -conf=$CONF getblock "$hash" 2 | jq '[.tx[].vout | length] | add'