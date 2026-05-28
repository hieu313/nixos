{ pkgs, ... }:

{
  imports = [
    ./programs/tmux.nix
    ./programs/neovim.nix
    ./dev/java.nix
    ./dev/python.nix
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
    fnm
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
    php82
    php82Packages.composer
    pipes-rs
    pnpm
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

  xdg.configFile = {
    "fzf/fzf-git.sh".source = ../config/fzf/fzf-git.sh;
    "starship.toml".source = ../config/starship/starship.main.toml;
    "eza/theme.yml".source = ../config/eza/eza.main.yml;
    "fastfetch/config.jsonc".source = ../config/fastfetch/main.fastfetch;
    "lazygit/config.yml".source = ../config/lazygit/tokyonight_moon.yml;
    "yazi/init.lua".source = ../config/yazi/init.lua;
    "yazi/yazi.toml".source = ../config/yazi/yazi.toml;
    "yazi/keymap.toml".source = ../config/yazi/keymap.toml;
    "yazi/theme.toml".source = ../config/yazi/theme.toml;
    "atuin/config.toml".source = ../config/atuin/config.toml;
    "atuin/themes/catppuccin-macchiato-mauve.toml".source = ../config/atuin/themes/macchiato/catppuccin-macchiato-mauve.toml;
    "git/ignore".source = ../config/git/.gitignore_global;
  };

  xdg.configFile."bat" = {
    source = ../config/bat;
    recursive = true;
  };

  xdg.configFile."btop" = {
    source = ../config/btop;
    recursive = true;
  };

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "tokyo-night";
      theme_background = true;
      truecolor = true;
    };
  };

  home.file.".gitconfig".source = ../config/git/.gitconfig;
}
