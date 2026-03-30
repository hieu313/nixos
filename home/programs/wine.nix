{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    wineWow64Packages.stable
    winetricks
  ];

  home.sessionVariables.WINEDEBUG = "-all";
  home.sessionVariables.WINEPREFIX = "$HOME/WindowsApps";
}
