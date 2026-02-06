{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../../modules/baseline.nix # <-- shared config between laptop/desktop
    ../../../modules/flatpak.nix
    ../../../modules/niri.nix #     <-- niri environment
    # ../../../modules/hypr.nix     <-- hyprland environment
    # ../../../modules/gnome.nix    <-- gnome environemt
    # ../../../modules/kde.nix      <-- kde environment
    # ../../../modules/xfce.nix     <-- xfce environment
    ../../../modules/storagebox.nix
    ../../../modules/syncthing-retroshare.nix
    ../../../modules/nixvim.nix
    ../../../modules/yazi.nix
    ../../../modules/virtualization.nix
  ];

  # hostname
  networking.hostName = "prometheus";
  hardware.cpu.amd.updateMicrocode = true;

  workstation = {
    baseline.enable = true;       # enable workstation baseline module
    retroshare.enable = true;     # enables ROM sync to server
    nixvim.enable = true;         # enable nixvim configuration
    niri.enable = true;           # change to a different profile if you want
    yazi.enable = true;           # yazi
    virtualization.enable = true; # enable QEMU/KVM virtualization
    flatpak = {
      enable = true;
      packages = [
        "flathub:app/app.zen_browser.zen//stable"
        "flathub:app/com.github.tchx84.Flatseal//stable"
      ];
    };
  };

  # environments, switch to true as needed
  # workstation.hypr.enable = true;
  # workstation.gnome.enable = true;
  # workstation.kde.enable = true;
  # workstation.xfce.enable = true;

  programs.steam.enable = true;

  systemd.services.micmute-led-off = {
    description = "Turn off micmute LED at boot";
    wantedBy = [ "multi-user.target" ];
    after = [ "sysinit.target" ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c 'echo 0 > /sys/class/leds/platform::micmute/brightness || true'";
    };
  };

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  environment.systemPackages = with pkgs; [
    v4l-utils
    terraform
    distrobox
  ];
}
