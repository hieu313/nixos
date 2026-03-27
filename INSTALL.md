The following steps assume you would you like to build a bit for bit replica of my prometheus (laptop) build. The steps also assume you are testing the build out in a QEMU/KVM VM, but can be easily adapted to any machine. By default, these steps will boot you into my Niri + Noctalia Shell build. When I tested this guide, it took less than 10 minutes from the time I booted the VM for the first time and then booted into Niri.

Breaking changes
I may introduce changes that break this tutorial and forget to update the guide. This guide is valid as of commit #b694df032d if you need to build from that

VM Requirements
Firmware: UEFI
Display: Spice Server, Listen type "none", OpenGL checked and set to Auto
Video: VirtIO, 3D acceleration enabled
Recommended specs are 30GB storage, 8GB RAM, 4-6 vCPU's (it can obviously be done with less RAM and vCPU's, but build time and performance will be impacted)
Grab your ISO
Make sure to download the latest minimal NixOS installer from https://channels.nixos.org/nixos-25.11/latest-nixos-minimal-x86_64-linux.iso

Configure via SSH
It is easiest to configure the system via SSH. Once you're booted into the live iso, run sudo -i to get root, passwd to set root password. Get the IP of the machine from ip a s and complete the rest of the installation over SSH. You can also manually type out each command like a barbarian if you so choose.

Installation Commands
parted /dev/vda -- mklabel gpt
parted /dev/vda -- mkpart root ext4 512MB -4GB
parted /dev/vda -- mkpart swap linux-swap -4GB 100%
parted /dev/vda -- mkpart ESP fat32 1MB 512MB
parted /dev/vda -- set 3 esp on
mkfs.ext4 -L nixos /dev/vda1
mkswap -L swap /dev/vda2
mkfs.fat -F 32 -n boot /dev/vda3
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount -o umask=077 /dev/disk/by-label/boot /mnt/boot
swapon /dev/vda2
nixos-generate-config --root /mnt
cd /mnt/etc && mv nixos nix.bak
git clone https://codeberg.org/sensei/nixos && rm -rf nixos/.git
mv nix.bak/hardware-configuration.nix nixos/devices/laptop/prometheus/
IMPORTANT
Before proceeding, it is HIGHLY recommended that you review the following files and adjust as needed.

nixos/modules/packages.nix - remove packages you don't want
nixos/modules/baseline.nix - remove services you don't want
nixos/devices/laptop/prometheus/default.nix - most of the configuration is nested into the workstation module, you probably want to change workstation.packages.dev to false, disable workstation.retroshare as well as workstation.virtualization, and remove the age configs around lines 61-68. Disabling nixvim will save you a ton of build time, but keep in mind that the only other editor is VSCodium (Mod+X). If you disable nixvim, make sure you add vim to the environment packages if you want a terminal based editor. You will also save a ton of build time by removing terraform from the packages list in this file. You should delete the ./backup.nix import as it would serve no purpose here.
Installation (cont.)
cd nixos && git init && git add .
nixos-install --flake .#prometheus
nixos-enter --root /mnt -c 'passwd hieunm'
reboot
Post Installation
You should now be able to go back to your VM and get booted directly into your niri session. Press Mod+Shift+/ to get the keybind list. Note that you may open a terminal (Mod+Enter) and run Noctalia Shell manually with noctalia-shell &disown. Your following reboots will start Noctalia automatically.

I currently don't manage Noctalia Shell declaratively. Cleanest way is:

Copy the repo to your home folder: sudo cp -r /etc/nixos ~/nixos and cp ~/nixos/config/noctalia/{settings.json,colors.json} ~/.config/noctalia/ to get my settings and colors into the shell
Video Tutorial
Pretty much an exact clone of this guide if you wanna watch it first https://youtu.be/pPXmUFQbjzg
