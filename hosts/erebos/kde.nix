{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ../../profiles/common.nix
    ../../profiles/kde/system.nix
    ../../devices/desktop/erebos/default.nix
  ];
}
