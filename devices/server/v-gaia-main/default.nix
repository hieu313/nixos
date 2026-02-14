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
    ./disk-config.nix
    ../../../modules/nixvim.nix
  ];
  
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
    device = "nodev";
  };

  networking.hostName = "v-gaia-main";

  server.baseline.enable = true;

  workstation = {
    ssh.enable = true;
    nixvim.enable = true;
  };

}

