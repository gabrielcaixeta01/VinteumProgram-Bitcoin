#!/usr/bin/env bash
CONF="$HOME/developer/bitcoin-remote/.bitcoin.conf"
hash=$(bitcoin-cli -conf=$CONF getblockhash 123456)
bitcoin-cli -conf=$CONF getblock "$hash" 2 | jq '[.tx[].vout | length] | add'