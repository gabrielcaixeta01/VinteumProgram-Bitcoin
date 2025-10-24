#!/usr/bin/env bash
set -euo pipefail

# pasta onde o script está
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# bitcoin.conf fica em ../.config relativo à pasta solutions/
CONF="${CONF:-$DIR/../.config/bitcoin.conf}"
XPUB="xpub6Cx5tvq6nACSLJdra1A6WjqTo1SgeUZRFqsX5ysEtVBMwhCCRa4kfgFqaT2o1kwL3esB1PsYr3CUdfRZYfLHJunNWUABKftK2NjHUtzDms2"

# 1) monta o descriptor e pega a versão com checksum
DESC=$(bitcoin-cli -conf="$CONF" getdescriptorinfo "tr($XPUB/0/*)" | jq -r '.descriptor')

# 2) deriva só o índice 100
bitcoin-cli -conf="$CONF" deriveaddresses "$DESC" "[100,100]"