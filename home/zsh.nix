{
  config,
  pkgs,
  lib,
  hostName,
  ...
}:

{
  programs.zsh = {
    enable = true;
    enableCompletion = false; # Zinit handles zicompinit
    autocd = true;
    shellAliases = {
    };
    initContent = lib.mkMerge [
      (lib.mkOrder 550 ''
        source "$HOME/.config/zsh/all.zsh"
      '')
    ];
    history.size = 10000;
  };
}
