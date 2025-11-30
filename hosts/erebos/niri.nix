{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{

  imports = [
    ../../profiles/common.nix
    ../../profiles/niri/system.nix
    ../../devices/desktop/erebos/default.nix
  ];

}
