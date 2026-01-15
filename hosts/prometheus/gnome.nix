{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ../../profiles/common.nix
    ../../profiles/gnome/system.nix
    ../../devices/laptop/prometheus/default.nix
  ];
}