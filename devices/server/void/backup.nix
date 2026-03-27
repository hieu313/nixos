{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.borgbackup.jobs.void-home = {
    paths = [
      "/home/hieunm"
      "/var/lib/nixos-containers/tuwunel"
    ];
    exclude = [
      "/home/hieunm/.cache"
      "/home/hieunm/.nix-defexpr"
      "/home/hieunm/.nix-profile"
      "/home/hieunm/.mozilla"
      "/home/hieunm/.pki"
      "/home/hieunm/.steam"
      "/home/hieunm/.terraform.d"
      "/home/hieunm/.var"
      "/home/hieunm/matrix"
    ];
    encryption.mode = "repokey";
    encryption.passCommand = "cat /run/agenix/borg.void.age";
    environment.BORG_RSH = "ssh -i /home/hieunm/.ssh/borg";
    repo = "ssh://borg@100.106.154.7:22/mnt/backups/void_home";
    compression = "auto,zstd";
    prune.keep = {
      daily = 7;
      weekly = 4;
      monthly = 3;
    };
    preHook = ''
      systemctl stop container@tuwunel
    '';
    postHook = ''
      systemctl start container@tuwunel
      exit $exitStatus
    '';
    startAt = "daily";
  };

  age.secrets."borg.void.age" = {
    file = ../../../secrets/borg.void.age;
    path = "/run/agenix/borg.void.age";
    owner = "gumbo";
    group = "users";
    mode = "0400";
  };
}
