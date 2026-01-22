{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../../modules/baseline.nix # <-- shared config between laptop/desktop
    ../../../modules/niri.nix # <-- niri environment
    # ../../../modules/hypr.nix # <-- hyprland environment
    # ../../../modules/gnome.nix # <-- gnome environemt
    # ../../../modules/kde.nix # <-- kde environment
    # ../../../modules/xfce.nix # <-- xfce environment
    ../../../modules/storagebox.nix
    ../../../modules/syncthing-retroshare.nix
  ];

  # hostname
  networking.hostName = "prometheus";
  hardware.cpu.amd.updateMicrocode = true;

  # enable workstation baseline module
  workstation.baseline.enable = true;

  # environments, switch to true as needed
  workstation.niri.enable = true;
  # workstation.hypr.enable = true;
  # workstation.gnome.enable = true;
  # workstation.kde.enable = true;
  # workstation.xfce.enable = true;

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
