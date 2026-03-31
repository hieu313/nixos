#!/bin/bash
set -e

# ─────────────────────────────────────────────
# Colors & helpers
# ─────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

STEP=0
TOTAL=10

step() {
  STEP=$((STEP + 1))
  echo ""
  echo -e "${CYAN}${BOLD}━━━ [${STEP}/${TOTAL}] $1 ${RESET}"
}

ok() {
  echo -e "  ${GREEN}✔ $1${RESET}"
}

info() {
  echo -e "  ${YELLOW}→ $1${RESET}"
}

fail() {
  echo -e "  ${RED}✘ $1${RESET}"
  exit 1
}

# ─────────────────────────────────────────────
# Partition config
# ─────────────────────────────────────────────
TARGET_DISK=/dev/nvme0n1p6
ESP_UUID=D5C5-178D
SWAP_UUID=b7e49711-7edb-4071-b506-3ba54814c295

echo ""
echo -e "${BOLD}╔══════════════════════════════════════════╗${RESET}"
echo -e "${BOLD}║       NixOS Installer — host: aries      ║${RESET}"
echo -e "${BOLD}╚══════════════════════════════════════════╝${RESET}"
echo ""
echo -e "  Target root : ${YELLOW}${TARGET_DISK}${RESET}"
echo -e "  ESP UUID    : ${YELLOW}${ESP_UUID}${RESET}"
echo -e "  Swap UUID   : ${YELLOW}${SWAP_UUID}${RESET}"
echo ""
echo -e "${RED}${BOLD}  ⚠ All data on ${TARGET_DISK} will be erased!${RESET}"
echo -ne "  Continue? [y/N] "
read -r confirm
[[ "$confirm" =~ ^[Yy]$ ]] || fail "Cancelled by user."

# ─────────────────────────────────────────────

step "Format partition root (${TARGET_DISK})"
wipefs -fa $TARGET_DISK
mkfs.ext4 -L nixos-root $TARGET_DISK
ok "ext4 format complete"

step "Mount partitions"
mount $TARGET_DISK /mnt
ok "Mounted root → /mnt"
mkdir -p /mnt/boot
mount /dev/disk/by-uuid/$ESP_UUID /mnt/boot
ok "Mounted ESP  → /mnt/boot"
swapon /dev/disk/by-uuid/$SWAP_UUID
ok "Swap enabled"

step "Generate hardware-configuration.nix"
nixos-generate-config --root /mnt
ok "Created /mnt/etc/nixos/hardware-configuration.nix"

step "Clone flake repo (hieu313/nixos)"
cd /mnt/etc
mv nixos nixos.bak
git clone https://github.com/hieu313/nixos.git nixos
rm -rf nixos/.git
ok "Clone succeeded"

step "Sync hardware-configuration into flake"
cp nixos.bak/hardware-configuration.nix \
   nixos/devices/laptop/aries/hardware-configuration.nix
ok "Copied → devices/laptop/aries/hardware-configuration.nix"

step "Init git repo (flake requires tracked files)"
cd nixos
git config --global user.name "hieunm"
git config --global user.email "hieunm@gmail.com"
git init --initial-branch=master
git add .
git commit -m "Initial commit"
# git remote add httporigin https://github.com/hieu313/nixos.git
# git push -u httporigin master
ok "Git init complete"

step "Install NixOS (nixos-install)"
info "This step may take several minutes depending on network speed..."
nixos-install --flake '.#aries'
ok "nixos-install complete"

step "Copy nixos repo to home"
cp -r /mnt/etc/nixos /mnt/home/hieunm/nixos
ok "NixOS repo copied to /mnt/home/hieunm/nixos"

step "Set root password: nixos-enter --root /mnt -c 'passwd root'"
step "Set password for user hieunm: nixos-enter --root /mnt -c 'passwd hieunm'"
ok "Root and user hieunm passwords (set using commands above)"
