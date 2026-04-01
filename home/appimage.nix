{ pkgs, lib, ... }:
let
  cursor-ai = pkgs.callPackage ../pkgs/cursor-ai { };
in
{
  # Central registry for AppImage-style apps installed via Home Manager
  # Merge-friendly: home.packages concatenates across modules
  home.packages = [
    cursor-ai
  ];

  programs.zsh.shellAliases = {
    cursor-ai = "cursor-ai";
  };
}
