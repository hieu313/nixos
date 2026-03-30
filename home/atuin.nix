{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.atuin = {
    enable = true;
    settings = {
      auto_sync = true;
      sync_frequency = "5m";
      sync_address = "https://api.atuin.sh";
      search_mode = "fuzzy";
    };
		flags = [ "--disable-up-arrow" ];
  };

	xdg.configFile."atuin/config.toml".source = ../config/atuin/config.toml;
	xdg.configFile."atuin/themes/macchiato/catppuccin-macchiato-mauve.toml".source = ../config/atuin/themes/catppuccin-macchiato-mauve.toml;
}
