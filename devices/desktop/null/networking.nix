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
}
