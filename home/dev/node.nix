{ config, lib, pkgs, ... }:
let
  cfg = config.devStacks.node;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      fnm
      pnpm
    ];
  };
}
