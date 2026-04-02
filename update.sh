#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd -- "$(dirname -- "$0")" && pwd)"

cp ~/.config/noctalia/*.json "$SCRIPT_DIR/config/noctalia/"
cp ~/.config/yazi/package.toml "$SCRIPT_DIR/config/yazi/package.toml"
sudo nixos-rebuild switch --flake .#aries
sudo cp /boot/EFI/NixOS-boot/grubx64.efi /boot/EFI/ARCH/grubx64.efi