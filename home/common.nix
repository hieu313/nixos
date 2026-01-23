{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.username = "gumbo";
  home.homeDirectory = "/home/gumbo";
  home.stateVersion = "25.05";

  programs.git.enable = true;

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "tokyo-night";
      theme_background = true;
      truecolor = true;
    };
  };

  xdg.configFile = {
    "starship.toml".source = ../config/starship/starship.main.toml;
    "ghostty/config".source = ../config/ghostty/tokyo-night.ghostty;
    "eza/theme.yml".source = ../config/eza/eza.main.yml;
    "fuzzel/fuzzel.ini".source = ../config/fuzzel/tokyonight.fuzzel.ini;
    "fastfetch/config.jsonc".source = ../config/fastfetch/main.fastfetch;
    "fastfetch/violet.png".source = ../config/icons/violet.png;
  };

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  programs.home-manager.enable = true;
}
