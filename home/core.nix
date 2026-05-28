{ pkgs, ... }:

{
  home = {
    username = "hieunm";
    homeDirectory = "/home/hieunm";
    stateVersion = "25.05";
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
