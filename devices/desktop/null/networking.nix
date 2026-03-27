{
  config,
  lib,
  pkgs,
  ...
}:
{
  networking.wg-quick = {
    interfaces = {
      wg0 = {
        autostart = true;
        configFile = "/home/hieunm/wireguard/wg0.conf";
      };
    };
  };
  environment.systemPackages = with pkgs; [
    libnatpmp
  ];
 # age.secrets."wg0.age" = {
 #   file = ../../../secrets/wg0.age;
 #   path = "/run/agenix/wg0.age";
 #   owner = "hieunm";
 #   group = "users";
 #   mode = "0400";
 # };
}
