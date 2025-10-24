#!/usr/bin/env bash
set -euo pipefail

# pasta onde o script está
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# bitcoin.conf fica em ../.config relativo à pasta solutions/
CONF="${CONF:-$DIR/../.config/bitcoin.conf}"

hash=$(bitcoin-cli -conf=$CONF getblockhash 123321)

bitcoin-cli -conf=$CONF getblock "$hash" 2 |
jq -r '.tx[] | .txid as $txid | .vout[] | [$txid, .n, (.scriptPubKey.addresses[0] // .scriptPubKey.asm)] | @tsv' |
while IFS=$'\t' read -r txid n addr; do
  if bitcoin-cli -conf=$CONF gettxout "$txid" "$n" >/dev/null 2>&1; then
    echo "UTXO encontrado → $addr"
    exit 0
  fi
done