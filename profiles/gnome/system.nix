{ config, pkgs, ... }:

{
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.gnome.core-apps.enable = false;
  services.gnome.core-developer-tools.enable = false;
  services.gnome.games.enable = false;
  environment.gnome.excludePackages = with pkgs; [ gnome-tour gnome-user-docs ];
  services.sysprof.enable = true;

  environment.systemPackages = with pkgs; [
    tokyonight-gtk-theme
    rose-pine-cursor
    gnomeExtensions.blur-my-shell
    gnomeExtensions.vitals
    gnomeExtensions.user-themes
    gnomeExtensions.dash-to-dock
    gnomeExtensions.appindicator
  ];
  
{
  programs.dconf.profiles.user.databases = [
    {
      settings = {
        "org/gnome/mutter" = {
          experimental-features = [
            "scale-monitor-framebuffer"
            "variable-refresh-rate"
            "xwayland-native-scaling"
            "autoclose-xwayland"
          ];
        };
      };
    }
  ];
}

}