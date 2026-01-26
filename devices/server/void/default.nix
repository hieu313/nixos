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
    ./containers.nix
    ./firewall.nix
    ../../../modules/baseline.server.nix # <-- server baseline
    ../../../modules/ssh.nix
  ];

  networking.hostName = "void";

  
}