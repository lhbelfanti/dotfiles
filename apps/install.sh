#!/usr/bin/env bash

echo "Installing Apps..."

echo "Coin Tick"
unzip ./apps/CoinTick.app.zip
cp -R "./Coin Tick.app" /Applications

echo "Configuring iTerm2 powerlevel10k theme"
p10k configure