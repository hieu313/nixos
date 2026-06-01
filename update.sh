#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd -- "$(dirname -- "$0")" && pwd)"

if compgen -G "$HOME/.config/noctalia/*.json" >/dev/null; then
  cp "$HOME"/.config/noctalia/*.json "$SCRIPT_DIR/config/noctalia/"
fi

if [ -f "$HOME/.config/yazi/package.toml" ]; then
  cp "$HOME/.config/yazi/package.toml" "$SCRIPT_DIR/config/yazi/package.toml"
fi
sudo nixos-rebuild switch --flake ~/nixos#aries
