{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../../modules/storagebox.nix
    ../../../modules/syncthing-retroshare.nix
  ];

  # hostname
  networking.hostName = "prometheus";

  hardware.cpu.amd.updateMicrocode = true;

  # mounts Hetzner storagebox module - remove or set to false if cloning
  filesystems.storagebox.enable = true;

  # connects device to syncthing server - enables ROM sync across devices
  services.syncthing.retroshare.enable = true;

  programs.steam.enable = true;

  systemd.services.micmute-led-off = {
    description = "Turn off micmute LED at boot";
    wantedBy = [ "multi-user.target" ];
    after = [ "sysinit.target" ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c 'echo 0 > /sys/class/leds/platform::micmute/brightness || true'";
    };
  };

  environment.systemPackages = with pkgs; [
    v4l-utils
    picard
  ];
}