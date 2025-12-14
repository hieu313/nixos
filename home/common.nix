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

  programs.bash = {
    enable = true;
    shellAliases = {
      hello = "echo hey";
      ls = "eza";
      battery-health = "upower -i /org/freedesktop/UPower/devices/battery_BAT0";
      nix-forge2git = "rsync -avh --delete --exclude='.git' ~/nixos/ ~/git-repos/nix-cb/";
    };
    initExtra = ''
      # eval "$(${pkgs.starship}/bin/starship init bash)"
      export EZA_CONFIG_DIR="$HOME/.config/eza"
      export EZA_ICONS_AUTO=1
    '';
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
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
    "ghostty/config".source = ../config/ghostty/cyberdream.config;
    "eza/theme.yml".source = ../config/eza/eza.main.yml;
  };

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  programs.home-manager.enable = true;
}
