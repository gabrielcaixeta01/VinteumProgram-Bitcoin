#!/usr/bin/env bash
set -euo pipefail

# pasta onde o script está
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# bitcoin.conf fica em ../.config relativo à pasta solutions/
CONF="${CONF:-$DIR/../.config/bitcoin.conf}"

TXID="c346d9277128f5d67740f8847f11aff5cef440b6d102fcd5ddcdb40d9a12df42"

# pega a tx decodificada (nível 2 para incluir inputs)
TX=$(bitcoin-cli -conf=$CONF getrawtransaction "$TXID" true)

# soma outputs
out_sum=$(printf '%s' "$TX" | jq '[.vout[].value] | add')

# soma inputs
in_sum=0
for i in $(printf '%s' "$TX" | jq -r '.vin[].txid'); do
  n=$(printf '%s' "$TX" | jq -r ".vin[] | select(.txid==\"$i\") | .vout")
  val=$(bitcoin-cli -conf=$CONF getrawtransaction "$i" true | jq ".vout[$n].value")
  in_sum=$(bc <<< "$in_sum + $val")
done

# fee (em satoshis)
bc <<< "($in_sum - $out_sum) * 100000000"