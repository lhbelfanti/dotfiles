#!/usr/bin/env bash

echo "Copying dotfiles..."

cp -r ./dotfiles/. ~/
rm ~/install.sh

echo "Creating folder for nvm"
mkdir ~/.nvm