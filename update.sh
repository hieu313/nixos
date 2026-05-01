#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd -- "$(dirname -- "$0")" && pwd)"

cp ~/.config/noctalia/*.json "$SCRIPT_DIR/config/noctalia/"
cp ~/.config/yazi/package.toml "$SCRIPT_DIR/config/yazi/package.toml"
sudo nixos-rebuild switch --flake ~/nixos#aries

