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

command -v nix >/dev/null || fail "nix is required"
command -v sudo >/dev/null || fail "sudo is required"

export NIX_CONFIG="experimental-features = nix-command flakes ${NIX_CONFIG:-}"

if ! command -v git >/dev/null; then
  info "Install git"
  nix profile install nixpkgs#git
fi

if ! grep -qi microsoft /proc/sys/kernel/osrelease 2>/dev/null; then
  fail "Run this inside a WSL distro"
fi

if [ -d "$REPO_DIR/.git" ]; then
  info "Update repo at $REPO_DIR"
  if ! git -C "$REPO_DIR" diff --quiet || ! git -C "$REPO_DIR" diff --cached --quiet; then
    fail "Repo has local changes: $REPO_DIR"
  fi
  git -C "$REPO_DIR" pull --ff-only
else
  info "Clone repo to $REPO_DIR"
  git clone "$REPO_URL" "$REPO_DIR"
fi

cd "$REPO_DIR"

info "Evaluate .#$HOST"
nix eval ".#nixosConfigurations.$HOST.config.system.build.toplevel.drvPath" >/dev/null

info "Apply .#$HOST"
sudo nixos-rebuild switch --flake ".#$HOST"

ok "NixOS-WSL config applied"
ok "Restart WSL from Windows with: wsl.exe --shutdown"
