{
  config,
  lib,
  pkgs,
  ...
}: {
  fileSystems = {
    # Arch Linux /home partition
    "/home/arch" = {
      device = "/dev/disk/by-uuid/4e7b15ac-054a-44e6-96c3-644ac60effd2";
      fsType = "ext4";
      options = [ "defaults" "nofail" ];
    };

    # Workspace
    "/home/hieunm/Workspace" = {
      device = "/dev/disk/by-uuid/34553dc9-ca35-4885-b542-66f442a45305";
      fsType = "ext4";
      options = [ "defaults" "nofail" ];
    };

    # Data (NTFS)
    "/home/hieunm/Data" = {
      device = "/dev/disk/by-uuid/CEA89ED4A89EBA83";
      fsType = "ntfs3";
      options = [ "uid=1000" "gid=981" "umask=000" "nofail" ];
    };
  };

  systemd.tmpfiles.rules = [
    "d /home/arch 0755 root root -"
  ];
}