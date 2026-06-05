{
  config,
  lib,
  hostName,
  ...
}:
# local.zsh Information
# - The config/zsh/local.zsh file is committed as an empty template.
# - Its purpose is to store API keys or any other sensitive information locally.
# - Local changes are ignored by git via: git update-index --skip-worktree config/zsh/local.zsh
# - How to Use:
#   - Add your API keys directly to config/zsh/local.zsh — changes won't be committed.
#   - If you don't need it, delete the last line in all.zsh to skip sourcing it.
{
  xdg.configFile."zsh" = {
    source = ../../config/zsh;
    recursive = true;
  };

  xdg.configFile."zsh/local.zsh" = {
    source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/nixos/config/zsh/local.zsh";
  };


  programs.zsh = {
    enable = true;
    enableCompletion = false; # Zinit handles zicompinit
    autocd = true;
    shellAliases = {
    };
    initContent = lib.mkMerge [
      (lib.mkBefore ''
        DISABLE_AUTO_UPDATE="true"
        DISABLE_MAGIC_FUNCTIONS="true"
        DISABLE_COMPFIX="true"
      '')

      (lib.mkAfter ''
        source "''${XDG_CONFIG_HOME:-$HOME/.config}/zsh/all.zsh"
      '')
    ];
    history.size = 10000;
  };
}
