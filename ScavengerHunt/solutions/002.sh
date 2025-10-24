#!/usr/bin/env bash
CONF="$HOME/developer/bitcoin-remote/.bitcoin.conf"
ADDR='1E9YwDtYf9R29ekNAfbV7MvB4LNv7v3fGa'
SIG='HCsBcgB+Wcm8kOGMH8IpNeg0H4gjCrlqwDf/GlSXphZGBYxm0QkKEPhh9DTJRp2IDNUhVr0FhP9qCqo2W0recNM='
MSG='1E9YwDtYf9R29ekNAfbV7MvB4LNv7v3fGa'

bitcoin-cli -conf="$CONF" verifymessage "$ADDR" "$SIG" "$MSG"