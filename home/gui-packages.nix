{ pkgs, ... }:

let
  nixAlienPkgs = import (builtins.fetchTarball {
    url = "https://github.com/thiagokokada/nix-alien/tarball/4c5e52dda0d6ab3de814e364046769321d3e1021";
    sha256 = "sha256-TRts0fKUPFcf1i6rZHFGUDTfti/x3oKEg/CqsPRpSgs=";
  }) {
    inherit pkgs;
  };
in
{
  imports = [
    ./gui-assets.nix
    ./flatpak.nix
    ./appimage.nix
    ./programs/obs.nix
    ./programs/dolphin.nix
    ./programs/jetbrains.nix
  ];

  home.packages = with pkgs; [
    cliphist
    evtest
    ffmpeg
    ffmpegthumbnailer
    flameshot
    font-manager
    ghostty
    google-chrome
    grim
    imagemagick
    ipatool
    kdePackages.konsole
    libreoffice
    mpv
    nautilus
    nemo-with-extensions
    pavucontrol
    poppler-utils
    postman
    satty
    slurp
    swappy
    telegram-desktop
    (tesseract.override {
      enableLanguages = [ "eng" ];
    })
    wf-recorder
    wl-clipboard
    wl-screenrec
    yt-dlp
    zenity
    nixAlienPkgs.nix-alien
    discord
  ];
}
