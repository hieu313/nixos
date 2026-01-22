{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.filesystems.games;
in
{
  options.filesystems.games.enable = lib.mkEnableOption "Local media filesystem for storing video game files";

  config = lib.mkIf cfg.enable {
    fileSystems."/mnt/games" = {
      device = "/dev/disk/by-uuid/7b2f5538-ff2f-44a7-9a7e-105bf75d6c70";
      fsType = "ext4";
      options = [
        "nosuid"
        "nodev"
        "noatime"
        "nofail"
      ];
    };
  };
}