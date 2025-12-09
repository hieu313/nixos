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
      "libvirtd"
    ];
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
  programs.neovim.enable = true;

  # virtualization
  programs.virt-manager.enable = true;
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu.swtpm.enable = true;
    };
    spiceUSBRedirection.enable = true;
  };

  environment.systemPackages = with pkgs; [
    wget
    git
    htop
    curl
    tree
    eza
    ghostty
    fastfetch
    starship
    bitwarden-desktop
    spotify
    yubioath-flutter
    vscode
    lazyssh
    signal-desktop
    nixfmt-rfc-style
    (retroarch.withCores (cores: with cores; [ mgba ]))
    upower
    blueman
    ffmpeg
    vlc
    whois
    rustup
    cargo
    gcc
  ];

  services = {
    tailscale.enable = true;
    openssh.enable = true;
    pcscd.enable = true; # yubikey dep
    qemuGuest.enable = true;
    spice-vdagentd.enable = true;
    libinput.enable = true;
    upower.enable = true;
    power-profiles-daemon.enable = true;
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

  environment.shellAliases = {
    list_sys_gens = "sudo nix-env -p /nix/var/nix/profiles/system --list-generations";

  };

  system.stateVersion = "25.05";

}
