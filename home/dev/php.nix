{ config, lib, pkgs, ... }:
let
  cfg = config.devStacks.php;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      php82
      php82Packages.composer
    ];
  };
}
