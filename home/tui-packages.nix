{ pkgs, ... }:

{
  imports = [
    ./tui-assets.nix
    ./programs/tmux.nix
    ./programs/neovim.nix
    ./dev/stacks.nix
    ./dev/java.nix
    ./dev/python.nix
    ./dev/php.nix
    ./dev/node.nix
  ];

  home.packages = with pkgs; [
    atool
    atuin
    awscli2
    bat
    cbonsai
    cloudflared
    cmatrix
    cowsay
    croc
    curl
    delta
    direnv
    duf
    eza
    fastfetch
    fd
    fzf
    gcc
    gifski
    git-extras
    gnumake
    go
    golangci-lint
    gopls
    gotools
    jq
    lazydocker
    lazygit
    lazysql
    navi
    ncdu
    nix-direnv
    openssl
    pay-respects
    pipes-rs
    pokemon-colorscripts
    rclone
    ripgrep
    ripgrep-all
    rustc
    cargo
    serie
    sl
    starship
    stow
    stripe-cli
    superfile
    tldr
    translate-shell
    trashy
    unar
    unzip
    wget
    yamllint
    yazi
    yq-go
    zbar
    zoxide
  ];


  programs.btop = {
    enable = true;
    settings = {
      color_theme = "tokyo-night";
      theme_background = true;
      truecolor = true;
    };
  };
}
