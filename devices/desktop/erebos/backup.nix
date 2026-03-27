{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.borgbackup.jobs.erebos-home = {
    paths = "/home/hieunm";
    exclude = [
      "/home/hieunm/.cache"
      "/home/hieunm/.nix-defexpr"
      "/home/hieunm/.nix-profile"
      "/home/hieunm/.mozilla"
      "/home/hieunm/.pki"
      "/home/hieunm/.steam"
      "/home/hieunm/.terraform.d"
      "/home/hieunm/.var"
    ];
    encryption.mode = "repokey";
    encryption.passCommand = "cat /run/agenix/borg.erebos.age";
    environment.BORG_RSH = "ssh -i /home/hieunm/.ssh/borg";
    repo = "ssh://borg@100.106.154.7:22/mnt/backups/erebos_new";
    compression = "auto,zstd";
    prune.keep = {
      daily = 7;
      weekly = 4;
      monthly = 3;
    };
    startAt = [ ];
  };

  age.secrets."borg.erebos.age" = {
    file = ../../../secrets/borg.erebos.age;
    path = "/run/agenix/borg.erebos.age";
    owner = "gumbo";
    group = "users";
    mode = "0400";
  };
}
