{
  config,
  pkgs,
  lib,
  ...
}:
{
  # Configs mapped in other modules (not here):
	#   zsh/*         → home/programs/zsh.nix
  #   hypr/*, waybar/*, icons/future-cyan  → home/desktop/hypr.nix
  #   niri/*, ghostty/ (niri variant)      → home/desktop/niri.nix
  #   ghostty/ (kde variant)               → home/desktop/kde.nix

	home.file.".face".source = ../pics/fox.jpg;

  xdg.configFile = {
    "fzf/fzf-git.sh".source = ../config/fzf/fzf-git.sh;
    "starship.toml".source = ../config/starship/starship.main.toml;
    "eza/theme.yml".source = ../config/eza/eza.main.yml;
    "fuzzel/fuzzel.ini".source = ../config/fuzzel/tokyonight.fuzzel.ini;
    "fastfetch/config.jsonc".source = ../config/fastfetch/main.fastfetch;
    "qt5ct/qt5ct.conf".source = ../config/qt5ct/qt5ct.conf;
    "qt5ct/colors/noctalia.conf".source = ../config/qt5ct/colors/noctalia.conf;
		"qt6ct/qt6ct.conf".source = ../config/qt6ct/qt6ct.conf;
		"qt6ct/style-colors.conf".source = ../config/qt6ct/style-colors.conf;
		"lazygit/config.yml".source = ../config/lazygit/tokyonight_moon.yml;
  };

  xdg.configFile."kitty" = {
    source = ../config/kitty;
    recursive = true;
  };

	xdg.configFile."Kvantum" = {
		source = ../config/Kvantum;
		recursive = true;
	};

	xdg.configFile."btop" = {
		source = ../config/btop;
		recursive = true;
	};

	xdg.configFile."fcitx5" = {
		source = ../config/fcitx5;
		recursive = true;
	};

	xdg.configFile."yazi/init.lua".source = ../config/yazi/init.lua;
	xdg.configFile."yazi/yazi.toml".source = ../config/yazi/yazi.toml;
	xdg.configFile."yazi/theme.toml".source = ../config/yazi/theme.toml;
	xdg.configFile."yazi/package.toml".source = ../config/yazi/package.toml;

	xdg.configFile."atuin/config.toml".source = ../config/atuin/config.toml;
	xdg.configFile."atuin/themes/catppuccin-macchiato-mauve.toml".source = ../config/atuin/themes/macchiato/catppuccin-macchiato-mauve.toml;

  home.file.".gitconfig".source = ../config/git/.gitconfig;
  xdg.configFile."git/ignore".source = ../config/git/.gitignore_global;
}