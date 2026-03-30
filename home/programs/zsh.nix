{
  config,
  pkgs,
  lib,
  hostName,
  ...
}:

{
  xdg.configFile."zsh" = {
    source = ../../config/zsh;
    recursive = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = false; # Zinit handles zicompinit
    autocd = true;
    shellAliases = {
    };
    initContent = lib.mkMerge [
      (lib.mkOrder 550 ''
        source "$XDG_CONFIG_HOME/zsh/all.zsh"
      '')
    ];
    history.size = 10000;
  };
}
