{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.workstation.warp;
in
{
  options.workstation.warp.enable = lib.mkEnableOption "Enable warp support";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.cloudflare-warp ];
    systemd.packages = [ pkgs.cloudflare-warp ];
    systemd.targets.multi-user.wants = [ "warp-svc.service" ];
  };
}
