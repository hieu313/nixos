{
  config,
  pkgs,
  lib,
  ...
}:
{
  # Configs mapped in other modules (not here):
  #   atuin/*         → home/programs/atuin.nix
  #   hypr/*, waybar/*, icons/future-cyan  → home/desktop/hypr.nix
  #   niri/*, ghostty/ (niri variant)      → home/desktop/niri.nix
  #   ghostty/ (kde variant)               → home/desktop/kde.nix

  xdg.configFile = {
    "starship.toml".source = ../config/starship/starship.main.toml;
    "eza/theme.yml".source = ../config/eza/eza.main.yml;
    "fuzzel/fuzzel.ini".source = ../config/fuzzel/tokyonight.fuzzel.ini;
    "fastfetch/config.jsonc".source = ../config/fastfetch/main.fastfetch;
    "qt5ct/qt5ct.conf".source = ../config/qt5ct/qt5ct.conf;
    "qt5ct/colors/noctalia.conf".source = ../config/qt5ct/colors/noctalia.conf;
  };

  xdg.configFile."kitty" = {
    source = ../config/kitty;
    recursive = true;
  };

  xdg.configFile."zsh" = {
    source = ../config/zsh;
    recursive = true;
  };

  home.file.".gitconfig".source = ../config/git/.gitconfig;
  xdg.configFile."git/ignore".source = ../config/git/.gitignore_global;
}