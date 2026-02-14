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
    ../../../modules/nixvim.nix
    ./containers.nix
    ./firewall.nix
    ./backup.nix
  ];

  users.users.gumbo = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "docker"
      "networkmanager"
      "sound"
      "video"
      "audio"
      "borg"
    ];
  };



  boot.loader.grub = {
    enable = true;
    devices = [ "/dev/sda" ];
  };

  networking.hostName = "void";

  server.baseline.enable = true;
  workstation = {
    ssh.enable = true;
    nixvim.enable = true;
  };
}
