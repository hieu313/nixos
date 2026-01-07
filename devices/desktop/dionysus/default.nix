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

  # Hostname
  networking.hostName = "dionysus";

  hardware.cpu.amd.updateMicrocode = true;

}
