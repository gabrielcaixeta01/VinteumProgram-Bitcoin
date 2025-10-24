#!/usr/bin/env bash
set -euo pipefail

CONF="$HOME/developer/bitcoin-remote/.bitcoin.conf"

# Cole aqui o TXID exatamente como está no enunciado (da sua imagem):
TXID="37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517"

# Busca a transação já decodificada
TX_JSON="$(bitcoin-cli -conf="$CONF" getrawtransaction "$TXID" true)"

# Extrai possíveis pubkeys:
# - de scriptSig.asm (legacy): último token costuma ser a pubkey
# - de txinwitness (segwit): último elemento costuma ser a pubkey
PUBKEYS=$(
  printf '%s' "$TX_JSON" | jq -r '
    [
      # pubkeys de scriptSig (legacy)
      (.vin[]?.scriptSig?.asm // "" | split(" ") | last),
      # pubkeys de witness (segwit)
      (.vin[]?.txinwitness // [] | last)
    ]
    | map(select(. != null and . != ""))        # remove vazios
    | map(select((test("^[0-9a-fA-F]{66}$")) or (test("^[0-9a-fA-F]{130}$"))))  # 33B/65B
    | unique
    | .[0:4]                                    # garantimos 4
  '
)

# Garante que temos 4 chaves
if [ "$(printf '%s' "$PUBKEYS" | jq 'length')" -ne 4 ]; then
  echo "Erro: não achei exatamente 4 pubkeys únicas nos inputs." >&2
  printf 'Encontrei: %s\n' "$(printf '%s' "$PUBKEYS")" >&2
  exit 1
fi

# Cria endereço multisig 1-de-4 (P2SH por padrão)
bitcoin-cli -conf="$CONF" createmultisig 1 "$(printf '%s' "$PUBKEYS")"