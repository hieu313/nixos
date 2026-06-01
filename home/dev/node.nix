{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fnm
    pnpm
  ];
}
