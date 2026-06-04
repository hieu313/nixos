{
  config,
  pkgs,
  lib,
  hostName,
  ...
}:
let
  cursor = {
    name = "Future-cursors";
    package = pkgs.callPackage ../../pkgs/future-cursor.nix { };
    size = 20;
  };

  niriConfigTemplate =
    if
      builtins.elem hostName [
        "prometheus"
        "aries"
      ]
    then
      ../../config/niri/config.laptop.kdl
    else
      ../../config/niri/config.desktop.kdl;

  niriConfig =
    builtins.replaceStrings
      [ "@cursorTheme@" "@cursorSize@" ]
      [ cursor.name (builtins.toString cursor.size) ]
      (builtins.readFile niriConfigTemplate);
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
      name = cursor.name;
      package = cursor.package;
      size = cursor.size;
    };

    gtk3.extraConfig = {
      "gtk-application-prefer-dark-theme" = true;
      "gtk-cursor-theme-name" = cursor.name;
    };

    gtk4.extraConfig = {
      "gtk-application-prefer-dark-theme" = true;
      Settings = ''
        gtk-cursor-theme-name=${cursor.name}
        gtk-cursor-theme-size=${builtins.toString cursor.size}
      '';
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "qt6ct";
    style = {
      name = "kvantum";
      package = pkgs.kdePackages.qtstyleplugin-kvantum;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Tokyonight-Dark";
      icon-theme = "Papirus";
      cursor-theme = cursor.name;
      cursor-size = cursor.size;
    };
  };

  xdg.configFile = {
    "gtk-3.0/settings.ini".force = true;
    "gtk-4.0/settings.ini".force = true;
    "gtk-4.0/gtk.css".force = true;
    "niri/config.kdl".text = niriConfig;
    "niri/noctalia.kdl".source = ../../config/niri/noctalia.kdl;
    "ghostty/config".source = ../../config/ghostty/tokyo-night.ghostty;
  };

  home.pointerCursor = {
    name = cursor.name;
    package = cursor.package;
    size = cursor.size;
    gtk.enable = true;
    x11.enable = true;
  };

  home.sessionVariables = {
    XCURSOR_THEME = cursor.name;
    XCURSOR_SIZE = builtins.toString cursor.size;
    NIXOS_OZONE_WL = "1";
    ICON_THEME = "Papirus";
    QS_ICON_THEME = "Papirus";
    QT_QPA_PLATFORM = "wayland";
    GTK_THEME = "Tokyonight-Dark";
  };
}
