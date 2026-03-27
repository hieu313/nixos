{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.workstation.docker;
in
{
  options.workstation.docker.enable = lib.mkEnableOption "Enable Docker support";

  config = lib.mkIf cfg.enable {
    virtualisation.docker.enable = true;
  };
}
