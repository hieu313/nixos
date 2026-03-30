# Disk layout: nvme0n1 — root p4, ESP p11, swap p10 (see lsblk on target machine).
# Regenerate after install if partitions change: sudo nixos-generate-config --show-hardware-config
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/ee5e8f38-3176-47a1-b00f-a5b9dc7ef605";
    fsType = "ext4";
  };

  # ESP (nvme0n1p11). NixOS mounts EFI at /boot, not /boot/efi like some distros.
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/D5C5-178D";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/b7e49711-7edb-4071-b506-3ba54814c295"; }
  ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
