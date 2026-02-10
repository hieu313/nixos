{ config, pkgs, lib, ... }:
{
  age.identityPaths = [ "/home/gumbo/.ssh/id_ed25519" ];
    age.secrets.matrix-env = {
    file = ../../../secrets/matrix.env;
    path = "/run/agenix/matrix.env";
    owner = "gumbo";
    group = "users";
    mode = "0400";
  };

  boot.kernel.sysctl."net.ipv4.ip_unprivileged_port_start" = 80;
  boot.kernel.sysctl."net.ipv6.ip_unprivileged_port_start" = 80;

}
