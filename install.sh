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
echo -e "${RED}${BOLD}  ⚠ Toàn bộ dữ liệu trên ${TARGET_DISK} sẽ bị xoá!${RESET}"
echo -ne "  Xác nhận tiếp tục? [y/N] "
read -r confirm
[[ "$confirm" =~ ^[Yy]$ ]] || fail "Hủy bởi người dùng."

# ─────────────────────────────────────────────

step "Format partition root (${TARGET_DISK})"
wipefs -fa $TARGET_DISK
mkfs.ext4 -L nixos-root $TARGET_DISK
ok "Format ext4 hoàn tất"

step "Lấy UUID mới của root partition"
ROOT_UUID=$(blkid -s UUID -o value $TARGET_DISK)
info "ROOT_UUID = ${ROOT_UUID}"

step "Mount các partition"
mount /dev/disk/by-uuid/$ROOT_UUID /mnt
ok "Mounted root → /mnt"
mkdir -p /mnt/boot
mount /dev/disk/by-uuid/$ESP_UUID /mnt/boot
ok "Mounted ESP  → /mnt/boot"
swapon /dev/disk/by-uuid/$SWAP_UUID
ok "Swap đã bật"

step "Generate hardware-configuration.nix"
nixos-generate-config --root /mnt
ok "File tạo tại /mnt/etc/nixos/hardware-configuration.nix"

step "Clone flake repo (hieu313/nixos)"
cd /mnt/etc
mv nixos nixos.bak
git clone https://github.com/hieu313/nixos.git nixos
rm -rf nixos/.git
ok "Clone thành công"

step "Đồng bộ hardware-configuration vào flake"
cp nixos.bak/hardware-configuration.nix \
   nixos/devices/laptop/aries/hardware-configuration.nix
ok "Đã copy → devices/laptop/aries/hardware-configuration.nix"

step "Init git repo (flake yêu cầu tracked files)"
cd nixos
git init
git add .
git commit -m "Initial commit"
ok "Git init hoàn tất"

step "Cài đặt NixOS (nixos-install)"
info "Bước này có thể mất vài phút tuỳ tốc độ mạng..."
nixos-install --flake '.#aries'
ok "nixos-install hoàn tất"

step "Đặt password cho user hieunm"
nixos-enter --root /mnt -c 'passwd hieunm'
ok "Password đã đặt"

step "Cleanup & reboot"
swapoff -a || true
umount -R /mnt
ok "Unmount sạch"
echo ""
echo -e "${GREEN}${BOLD}  ✔ Cài đặt hoàn tất! Đang reboot...${RESET}"
echo ""
sleep 2
reboot