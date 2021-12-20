#!/bin/bash

if ! [ -f ~/.bitcoin/regtest/wallets/wallet.dat ]; then
  bitcoin-cli createwallet "" > /dev/null
fi

NUM_OF_BLOCKS=1
if [[ -n "$1" ]]; then
  NUM_OF_BLOCKS="$1"
fi

bitcoin-cli -generate "$NUM_OF_BLOCKS"
