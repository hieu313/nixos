{ pkgs, ... }:

{
  home.file.".face".source = ../pics/fox.jpg;

  xdg.configFile = {
    "fuzzel/fuzzel.ini".source = ../config/fuzzel/tokyonight.fuzzel.ini;
    "qt5ct/qt5ct.conf".source = ../config/qt5ct/qt5ct.conf;
    "qt5ct/colors/noctalia.conf".source = ../config/qt5ct/colors/noctalia.conf;
    "qt6ct/qt6ct.conf".source = ../config/qt6ct/qt6ct.conf;
    "qt6ct/style-colors.conf".source = ../config/qt6ct/style-colors.conf;
  };

  xdg.configFile."kitty" = {
    source = ../config/kitty;
    recursive = true;
  };

  xdg.configFile."Kvantum" = {
    source = ../config/Kvantum;
    recursive = true;
  };

  xdg.configFile."fcitx5" = {
    source = ../config/fcitx5;
    recursive = true;
  };

  xdg.configFile."noctalia/plugins/mini-docs" = {
    source = ../config/noctalia/plugins/mini-docs;
    recursive = true;
  };

  programs.kitty.enable = true;

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  xdg.mimeApps.defaultApplications = {
    "inode/directory" = "org.kde.dolphin.desktop";
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
