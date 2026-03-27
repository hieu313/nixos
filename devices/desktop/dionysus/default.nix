{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "dionysus";

  services.seatd = {
    enable = true;
    user = "hieunm";
    group = "video";
  };

  services.getty = {
    autologinUser = "hieunm";
  };

  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    gamescope
  ];
}
