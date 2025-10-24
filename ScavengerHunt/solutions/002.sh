#!/usr/bin/env bash
set -euo pipefail

# pasta onde o script está
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# bitcoin.conf fica em ../.config relativo à pasta solutions/
CONF="${CONF:-$DIR/../.config/bitcoin.conf}"

ADDR='1E9YwDtYf9R29ekNAfbV7MvB4LNv7v3fGa'
SIG='HCsBcgB+Wcm8kOGMH8IpNeg0H4gjCrlqwDf/GlSXphZGBYxm0QkKEPhh9DTJRp2IDNUhVr0FhP9qCqo2W0recNM='
MSG='1E9YwDtYf9R29ekNAfbV7MvB4LNv7v3fGa'

bitcoin-cli -conf="$CONF" verifymessage "$ADDR" "$SIG" "$MSG"