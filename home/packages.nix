{
  pkgs,
  lib,
  ...
}:
let

  nixAlienPkgs = import (builtins.fetchTarball {
    url = "https://github.com/thiagokokada/nix-alien/tarball/4c5e52dda0d6ab3de814e364046769321d3e1021";
    sha256 = "sha256-TRts0fKUPFcf1i6rZHFGUDTfti/x3oKEg/CqsPRpSgs=";
  }) {
    inherit pkgs;
  };

  packageGroups = {
    terminalShell = with pkgs; [
      starship
      fzf
      eza
      zoxide
      bat
    ];

    dev = with pkgs; [
      php82
      php82Packages.composer
      fnm
      pnpm
      go
      gopls
      gotools
      golangci-lint
      yamllint
			rustc
			cargo
			gcc
    ];

    cloudDevops = with pkgs; [
			gnumake
      awscli2
      stripe-cli
      cloudflared
      rclone
      lazydocker
      lazysql
			lazygit
			openssl
    ];

    cliTools = with pkgs; [
			atool
			atuin
			fastfetch
      fd
      ripgrep
      ripgrep-all
      tldr
      duf
      trashy
      ncdu
      stow
      croc
      delta
      git-extras
      navi
      yazi
      superfile
      serie
      pay-respects
      jq
      yq-go
      wl-clipboard
      yt-dlp
      (tesseract.override {
        enableLanguages = [ "eng" ];
      })
      zbar
      curl
      translate-shell
      ffmpeg
      gifski
			mpv

			ffmpegthumbnailer
			poppler-utils
			unar
			font-manager
    ];

    apps = with pkgs; [
			google-chrome
			nemo-with-extensions
      kdePackages.konsole
      nautilus
      pavucontrol
			ghostty
			libreoffice
      telegram-desktop
      ipatool
      imagemagick
      postman
    ];

    fun = with pkgs; [
      cbonsai
      cmatrix
      sl
      cowsay
      pipes-rs
			evtest
      pokemon-colorscripts
    ];

    waylandDesktop = with pkgs; [
      cliphist
      grim
      slurp
      swappy
      satty
      wf-recorder
      flameshot
      wl-screenrec
    ];

    extra = [
      nixAlienPkgs.nix-alien
    ];
  };

  allPackages = lib.flatten (builtins.attrValues packageGroups);
in
{
	imports = [
		# imports
		./flatpak.nix
    ./appimage.nix

		# programs
		./programs/obs.nix
		./programs/tmux.nix
		./programs/dolphin.nix
		./programs/neovim.nix
		./programs/jetbrains.nix

		# dev
		./dev/java.nix
    ./dev/python.nix
	];
  config = {
    home.packages = allPackages;
  };
}
# Note: to use wine, you need to install it manually with:
# flatpak install org.winehq.Wine
