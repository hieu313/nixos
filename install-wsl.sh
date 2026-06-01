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

cat <<'POST_INSTALL'

Next steps after install:
  1. Restart WSL from Windows:
     wsl.exe --shutdown

  2. Open WSL again, then run post-install setup for user-managed CLI state:
     mkdir -p ~/.config/yazi
     cp /etc/nixos-wsl/config/yazi/package.toml ~/.config/yazi/package.toml
     ya pkg install        # install exact Yazi plugin rev/hash from writable package.toml
     bat cache --build     # rebuild bat theme/syntax cache
     nvim                  # first run bootstraps lazy.nvim/LazyVim and Mason tools

  3. Start zsh once with network access.
     Zinit and zsh plugins bootstrap automatically on first shell startup.

  4. Set up Atuin sync/account manually if you use shared shell history:
     atuin register        # new account, or
     atuin login           # existing account
     atuin sync

Notes:
  - Neovim first run may download plugins and Mason tools such as typescript-language-server,
    eslint-lsp, prettier, and js-debug-adapter.
  - Yazi package.toml is copied to ~/.config/yazi instead of Home Manager symlink because
    ya pkg install may write package state and needs a writable file.
  - Use ya pkg install, not ya pkg upgrade. package.toml already pins Yazi plugins by rev/hash,
    while upgrade refreshes them to newer revisions and rewrites those pins.
POST_INSTALL

ok "Restart WSL from Windows with: wsl.exe --shutdown"
