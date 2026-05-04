{ pkgs, ... }:

{
  imports = [
    ./programs/zsh.nix
    ./programs/tmux.nix
    ./programs/neovim.nix
  ];

  home = {
    username = "hieunm";
    homeDirectory = "/home/hieunm";
    stateVersion = "25.05";

    packages = with pkgs; [
      bat
      curl
      delta
      eza
      fd
      fzf
      gcc
      git-extras
      jq
      lazydocker
      lazygit
      neovim
      pnpm
      ripgrep
      starship
      tmux
      unzip
      wget
      yazi
      zoxide
    ];
  };

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    package = pkgs.git;
    settings.core.editor = "nvim";
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
