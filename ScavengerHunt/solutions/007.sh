#!/usr/bin/env bash
set -euo pipefail
CONF="$HOME/developer/bitcoin-remote/.bitcoin.conf"

hash=$(bitcoin-cli -conf=$CONF getblockhash 123321)

bitcoin-cli -conf=$CONF getblock "$hash" 2 |
jq -r '.tx[] | .txid as $txid | .vout[] | [$txid, .n, (.scriptPubKey.addresses[0] // .scriptPubKey.asm)] | @tsv' |
while IFS=$'\t' read -r txid n addr; do
  if bitcoin-cli -conf=$CONF gettxout "$txid" "$n" >/dev/null 2>&1; then
    echo "UTXO encontrado → $addr"
    exit 0
  fi
done