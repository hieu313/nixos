{
  pkgs,
  lib,
  ...
}:
let
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
      python3Packages.pyclip
      python3Packages.httpx
      python3Packages.pillow
      python3Packages.curl-cffi
      python3Packages.cloudscraper
      python313Packages.unrpa
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
    ];

    apps = with pkgs; [
      kdePackages.konsole
      nautilus
      pavucontrol
			ghostty
			libreoffice
      telegram-desktop
      ipatool
      imagemagick
    ];

    fun = with pkgs; [
      cbonsai
      cmatrix
      sl
      cowsay
      pipes-rs
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
  };

  allPackages = lib.flatten (builtins.attrValues packageGroups);
in
{
	imports = [
		./flatpak.nix
    ./appimage.nix
		./programs/tmux.nix
		./programs/dolphin.nix
	];
  config = {
    home.packages = allPackages;
  };
}