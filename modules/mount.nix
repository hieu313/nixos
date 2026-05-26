{
  config,
  lib,
  pkgs,
  ...
}: {
  fileSystems = {
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
      options = [ "uid=1000" "gid=100" "umask=000" "nofail" ];
    };
  };
}