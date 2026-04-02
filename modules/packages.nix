{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.workstation.baseline.packages;

  systemPackages = with pkgs; [
    # Hardware and disk
    parted
    usbutils
    smartmontools
    pciutils
    ddcutil
    brightnessctl
		ntfs3g

    # Network
    wget
    curl
    whois
    bind
    inetutils
    rsync

    # System utilities
    file
    zip
    p7zip
    unrar
    unzip
    parallel
    git
    btop
    less
		appimage-run
  ];
in
{
  options.workstation.baseline.packages.enable =
    lib.mkEnableOption "baseline system packages";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = systemPackages;
  };
}