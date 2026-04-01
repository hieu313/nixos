{
  config,
  pkgs,
  lib,
  hostName,
  ...
}:
let
  niriConfig = if builtins.elem hostName [ "prometheus" "aries" ]
    then ../../config/niri/config.laptop.kdl 
    else ../../config/niri/config.desktop.kdl;
in
{
  gtk = {
    enable = true;
    theme = {
      name = "Tokyonight-Dark";
      package = pkgs.tokyonight-gtk-theme;
    };

    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };

    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 20;
    };

    gtk3.extraConfig = {
      "gtk-application-prefer-dark-theme" = true;
      "gtk-cursor-theme-name" = "Bibata-Modern-Classic";
    };

    gtk4.extraConfig = {
      "gtk-application-prefer-dark-theme" = true;
      Settings = ''
      gtk-cursor-theme-name=Bibata-Modern-Classic
      gtk-cursor-theme-size=16
      '';
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "Fusion";
  };

  xdg.configFile = {
    "gtk-3.0/settings.ini".force = true;
    "gtk-4.0/settings.ini".force = true;
    "gtk-4.0/gtk.css".force = true;
    "niri/config.kdl".source = niriConfig;
    "niri/noctalia.kdl".source = ../../config/niri/noctalia.kdl;
    "ghostty/config".source = ../../config/ghostty/tokyo-night.ghostty;
  };

  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 20;
    gtk.enable = true;
    x11.enable = true;
  };

  home.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "20";
    NIXOS_OZONE_WL = "1";
    ICON_THEME = "Papirus";
    QS_ICON_THEME = "Papirus";
    QT_QPA_PLATFORM      = "wayland";
  };
}
