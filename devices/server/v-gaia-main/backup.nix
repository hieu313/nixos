{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.borgbackup.jobs.v-gaia-main-home = {
    paths = "/home/gumbo";
    exclude = [
      "/home/gumbo/.cache"
      "/home/gumbo/.nix-defexpr"
      "/home/gumbo/.nix-profile"
      "/home/gumbo/.mozilla"
      "/home/gumbo/.pki"
      "/home/gumbo/.steam"
      "/home/gumbo/.terraform.d"
      "/home/gumbo/.var"
    ];
    encryption.mode = "repokey";
    encryption.passCommand = "cat /run/agenix/borg.v-gaia-main.age";
    environment.BORG_RSH = "ssh -i /home/gumbo/.ssh/borg";
    repo = "ssh://borg@100.106.154.7:22/mnt/backups/v-gaia-main_home";
    compression = "auto,zstd";
    prune.keep = {
      daily = 7;
      weekly = 4;
      monthly = 3;
    };
    startAt = "daily";
  };

  age.secrets."borg.v-gaia-main.age" = {
    file = ../../../secrets/borg.v-gaia-main.age;
    path = "/run/agenix/borg.v-gaia-main.age";
    owner = "gumbo";
    group = "users";
    mode = "0400";
  };
}
