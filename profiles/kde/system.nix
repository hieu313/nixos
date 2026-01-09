{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.defaultSession = "plasma" ;

  services.displayManager.sddm.settings.General.DisplayServer = "wayland";

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
  konsole
  elisa
];

  environment.systemPackages = with pkgs; [
    tokyonight-gtk-theme
    rose-pine-cursor
  ];

}
