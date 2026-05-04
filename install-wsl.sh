#!/usr/bin/env bash
set -euo pipefail

REPO_URL="${REPO_URL:-https://github.com/hieu313/nixos.git}"
REPO_DIR="${REPO_DIR:-/etc/nixos-wsl}"
HOST="${HOST:-wsl}"

info() {
  printf '→ %s\n' "$1"
}

ok() {
  printf '✓ %s\n' "$1"
}

fail() {
  printf '✗ %s\n' "$1" >&2
  exit 1
}

command -v git >/dev/null || fail "git is required"
command -v nix >/dev/null || fail "nix is required"

if ! grep -qi microsoft /proc/sys/kernel/osrelease 2>/dev/null; then
  fail "Run this inside the NixOS-WSL distro"
fi

info "Enable flakes for this shell"
export NIX_CONFIG="experimental-features = nix-command flakes ${NIX_CONFIG:-}"

if [ -d "$REPO_DIR/.git" ]; then
  info "Update repo at $REPO_DIR"
  git -C "$REPO_DIR" pull --ff-only
else
  info "Clone repo to $REPO_DIR"
  git clone "$REPO_URL" "$REPO_DIR"
fi

cd "$REPO_DIR"

info "Ensure new files are visible to flake evaluation"
git add flake.nix flake.lock devices/wsl/default.nix home/wsl.nix

info "Evaluate .#$HOST"
nix eval ".#nixosConfigurations.$HOST.config.networking.hostName" >/dev/null

info "Apply .#$HOST"
sudo nixos-rebuild switch --flake ".#$HOST"

ok "NixOS-WSL config applied"
ok "Restart WSL from Windows with: wsl.exe --shutdown"
