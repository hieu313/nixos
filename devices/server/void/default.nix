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
#    ./containers.nix
#    ./firewall.nix
  ];

  networking.hostName = "void";


  server.baseline.enable = true;
  workstation = {
    ssh.enable = true;
    nixvim.enable = true;
  };
}
