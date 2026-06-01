{ pkgs, ... }:

{
  wsl = {
    enable = true;
    defaultUser = "hieunm";
  };

  networking.hostName = "wsl";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Asia/Ho_Chi_Minh";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users.hieunm = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "docker"
    ];
  };

  programs = {
    zsh.enable = true;
    nix-ld.enable = true;
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      defaultEditor = true;
    };
  };

  virtualisation.docker.enable = true;

  system.stateVersion = "25.05";
}
