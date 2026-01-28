{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.server.baseline;
in
{
  options.server.baseline.enable = lib.mkEnableOption "Baseline server configuration";

  config = lib.mkIf cfg.enable {
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    nixpkgs.config.allowUnfree = true;

    networking.networkmanager.enable = true;

    boot.loader.grub = {
      enable = true;
      devices = [ "/dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_110561521" ];
    };

    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };

    time.timeZone = "America/Chicago";

    i18n.defaultLocale = "en_US.UTF-8";
    console = {
      font = "Lat2-Terminus16";
      keyMap = "us";
    };

    users.users.gumbo = {
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = [
        "wheel"
        "docker"
        "networkmanager"
        "sound"
        "video"
        "audio"
      ];
    };

    programs.zsh.enable = true;
    environment.pathsToLink = [ "/share/zsh" ];

    environment.systemPackages = with pkgs; [
      # tools/etc
      inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
      wget
      git
      htop
      curl
      tree
      fastfetch
      starship
      ffmpeg
      whois
      parted
      usbutils
      smartmontools
      pciutils
      file
      dig
      oh-my-zsh
      autojump
      compose2nix
      jq
      screen
      eza
    ];

    services = {
      tailscale.enable = true;
      qemuGuest.enable = true;
    };

    virtualisation.docker = {
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };

    networking.firewall.allowedTCPPorts = [ 22 ];

    system.stateVersion = "25.05";
  };
}
