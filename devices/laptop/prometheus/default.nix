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
  ];

  # Hostname
  networking.hostName = "prometheus";

  # Prometheus Tweaks

  hardware.cpu.amd.updateMicrocode = true;

  systemd.services.micmute-led-off = {
    description = "Turn off micmute LED at boot";
    wantedBy = [ "multi-user.target" ];
    after = [ "sysinit.target" ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c 'echo 0 > /sys/class/leds/platform::micmute/brightness || true'";
    };
  };

  programs.steam.enable = true;

  services.syncthing = {
    enable = true;
    user = "gumbo";
    group = "users";
    dataDir = "/home/gumbo/sync";
    configDir = "/home/gumbo/.config/syncthing";
    overrideDevices = false;
    overrideFolders = false;
    openDefaultPorts = true;
    settings = {
      devices = {
        "manga" = {
          id = "I3J5UCJ-NZIOJCX-FIV6PUT-QSTITFA-4TI6PB7-MVR67TI-SW56QXD-6ARBAAE";
        };
      };
      folders = {
        "retro-bios" = {
          id = "p4epq-mmgmv";
          path = "/home/gumbo/sync/retro/BIOS";
          devices = [
            "manga"
          ];
          type = "receiveonly";
        };
        "retro-roms" = {
          id = "74edp-unucu";
          path = "/home/gumbo/sync/retro/ROMs";
          devices = [
            "manga"
          ];
          type = "receiveonly";
        };
        "retro-saves" = {
          id = "ymtp3-m4ngw";
          path = "/home/gumbo/sync/retro/Saves";
          devices = [
            "manga"
          ];
          type = "sendreceive";
        };
      };
    };
  };

}
