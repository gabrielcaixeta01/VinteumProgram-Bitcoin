#!/usr/bin/env bash
CONF="$HOME/developer/bitcoin-remote/.bitcoin.conf"
bitcoin-cli -conf=$CONF getblockhash 654321