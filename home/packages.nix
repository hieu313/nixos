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
      tmux
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
    ];

    cloudDevops = with pkgs; [
      awscli2
      ngrok
      stripe-cli
      cloudflared
      rclone
      lazydocker
      lazysql
			lazygit
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
    ];

    apps = with pkgs; [
			libreoffice
			google-chrome
      telegram-desktop
			vscodium
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
      wl-clipboard
      grim
      slurp
      swappy
      satty
      wf-recorder
      flameshot
    ];
  };

  allPackages = lib.flatten (builtins.attrValues packageGroups);
in
{
	imports = [
		./flatpak.nix
	];
  config = {
    home.packages = allPackages;
  };
}