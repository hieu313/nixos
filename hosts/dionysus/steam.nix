{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{

  imports = [
    ../../profiles/steamos/system.nix
    ../../devices/desktop/dionysus/default.nix
  ];

}