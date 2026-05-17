{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.workstation.usbmuxd;
in
{
  options.workstation.usbmuxd.enable = lib.mkEnableOption "Enable usbmuxd support";

  config = lib.mkIf cfg.enable {
    services.usbmuxd.enable = true;

    environment.systemPackages = with pkgs; [
      libimobiledevice
      ifuse
    ];
  };
}