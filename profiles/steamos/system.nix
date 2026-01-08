{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  hardware.enableAllFirmware = true;

  networking.networkmanager.enable = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  time.timeZone = "America/Chicago";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  users.users.gumbo = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "sound"
      "video"
      "audio"
    ];
  };

  users.users.sensei = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "sound"
      "video"
      "audio"
    ];

    shell = pkgs.bash;

    loginShellInit = ''
      if [ "$(tty)" = "/dev/tty2" ]; then
        export XDG_SESSION_TYPE=wayland
        export XDG_CURRENT_DESKTOP=gamescope
        export GAMESCOPE_DEBUG=1
        export GAMESCOPE_DRM_DEVICE=/dev/dri/card2
        exec ${pkgs.gamescope}/bin/gamescope \
          --backend drm \
          -W 1920 -H 1080 -f -- \
          ${pkgs.steam}/bin/steam -tenfoot -gamepadui
      fi
    '';
  };

    services.getty = {
      enable = true;
      autologinUser = "sensei";
    };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        FastConnectable = false;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      inter
    ];
    fontconfig = {
      enable = true;

      defaultFonts = {
        sansSerif = [
          "Inter"
          "Noto Sans"
        ];
        serif = [ "Noto Serif" ];
        monospace = [ "JetBrainsMono Nerd Font" ];
      };
    };

    fontDir.enable = true;
  };

  programs.firefox.enable = true;
  programs.dconf.enable = true;
  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    wget
    git
    htop
    curl
    eza
    tree
    ghostty
    fastfetch
    starship
    spotify
    (retroarch.withCores (cores: with cores; [ mgba ]))
    blueman
    ffmpeg
    vlc
    parted
    usbutils
    smartmontools
    pciutils
    gamescope
  ];

  services = {
    tailscale.enable = true;
    openssh.enable = true;
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
    };
  };

  # flatpak
  services.flatpak = {
    enable = true;
  };

  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  system.stateVersion = "25.05";

}
