{
  config,
  lib,
  hostName,
  ...
}:
# keys.zsh Information
# - The config/zsh/keys.zsh file is committed as an empty template.
# - Its purpose is to store API keys or any other sensitive information locally.
# - Local changes are ignored by git via: git update-index --skip-worktree config/zsh/keys.zsh
# - How to Use:
#   - Add your API keys directly to config/zsh/keys.zsh — changes won't be committed.
#   - If you don't need it, delete the last line in all.zsh to skip sourcing it.
{
  xdg.configFile."zsh" = {
    source = ../../config/zsh;
    recursive = true;
  };

  xdg.configFile."zsh/keys.zsh" = {
    source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/nixos/config/zsh/keys.zsh";
  };


  programs.zsh = {
    enable = true;
    enableCompletion = false; # Zinit handles zicompinit
    autocd = true;
    shellAliases = {
    };
    initContent = lib.mkAfter ''
      export XDG_CONFIG_HOME="''${XDG_CONFIG_HOME:-$HOME/.config}"
      export XDG_CACHE_HOME="''${XDG_CACHE_HOME:-$HOME/.cache}"
      export XDG_DATA_HOME="''${XDG_DATA_HOME:-$HOME/.local/share}"
      export XDG_STATE_HOME="''${XDG_STATE_HOME:-$HOME/.local/state}"
      source "''${XDG_CONFIG_HOME:-$HOME/.config}/zsh/all.zsh"
    '';
    history.size = 10000;
  };
}
