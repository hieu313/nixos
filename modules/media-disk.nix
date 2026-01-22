{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.mount.media;
in
{
  options.mount.media.enable = lib.mkEnableOption "Local media mount for Jellyfin, Kavita, Immich, and Navidrome";

  config = lib.mkIf cfg.enable {
    fileSystems."/mnt/jelly" = {
      device = "/dev/disk/by-uuid/928958de-b7ae-4310-9465-57377da78508";
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
