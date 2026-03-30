{
  config,
  pkgs,
  lib,
  ...
}:
{
  # Central xdg.configFile mappings (static only)
  # Reference map:
  # - Recursive dirs:
  #   - home/hypr.nix:10-18 → ~/.config/hypr ← config/hypr; ~/.config/waybar ← config/waybar
  #   - home/hypr.nix:20-23 → xdg.dataFile icons: ~/.local/share/icons/future-cyan ← config/icons/future-cyan
  # - Niri + Ghostty:
  #   - home/niri.nix:9-12 → host-selects config/niri/config.{laptop,desktop}.kdl
  #   - home/niri.nix:41-48 → symlinks: niri/config.kdl, niri/noctalia.kdl, ghostty/config
  # - KDE + Ghostty:
  #   - home/kde.nix:32 → ghostty/config ← config/ghostty/tokyo-night.kde.ghostty
  # - Zsh config:
  #   - config/zsh/{all,aliases,token}.zsh → ~/.config/zsh/ (Zinit, plugins, env vars, functions)
  # - Atuin config:
  #   - config/atuin/config.toml → ~/.config/atuin/config.toml
  #   - config/atuin/themes/catppuccin-macchiato-mauve.toml → ~/.config/atuin/themes/catppuccin-macchiato-mauve.toml
  # - Env vars:
  #   - config/zsh/all.zsh → export EZA_CONFIG_DIR
  # - Internal reference:
  #   - config/hypr/hyprland.conf:29 → exec-once ~/.config/hypr/cycle-wall.sh

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
