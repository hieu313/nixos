{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.workstation.kde;
in
{
  options.workstation.kde.enable = lib.mkEnableOption "KDE Plasma-based workstation environment";

  config = lib.mkIf cfg.enable {
    services.xserver.enable = true;
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;
    services.displayManager.defaultSession = "plasma" ;

    environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole
    elisa
  ];

    environment.systemPackages = with pkgs; [
      tokyonight-gtk-theme
      rose-pine-cursor
    ];
  };
}
