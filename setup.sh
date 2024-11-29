#!/usr/bin/env bash

echo "-- Setup initialized --"

./dotfiles/install.sh
./scripts/install.sh
./homebrew/install.sh

echo "-- Setup finished --"