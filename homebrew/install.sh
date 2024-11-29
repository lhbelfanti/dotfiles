#!/usr/bin/env bash

echo "Installing Homebrew..."

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Installing Homebrew brews (libraries)..."
xargs brew install --formula < ./homebrew/brews.txt || true

echo "Installing Homebrew casks (applications)..."
xargs -I {} brew install --cask {} < ./homebrew/casks.txt || true
