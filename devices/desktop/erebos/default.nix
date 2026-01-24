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
    ../../../modules/niri.nix # <-- niri environment
    # ../../../../modules/hypr.nix # <-- hyprland environment
    # ../../../../modules/gnome.nix # <-- gnome environemt
    # ../../../../modules/kde.nix # <-- kde environment
    # ../../../../modules/xfce.nix # <-- xfce environment
    ../../../modules/storagebox.nix
    ../../../modules/games-disk.nix
    ../../../modules/media-disk.nix
    ../../../modules/ssh.nix
  ];

  # hostname
  networking.hostName = "erebos";

  # enable workstation baseline module
  workstation.baseline.enable = true;

  # enable default ssh configuration + authorized yubikeys
  workstation.ssh.enable = true;

  # environments, switch to true or false as needed
  workstation.niri.enable = true;
  # workstation.hypr.enable = true;
  # workstation.gnome.enable = true;
  # workstation.kde.enable = true;
  # workstation.xfce.enable = true;

  programs.steam.enable = true;
  programs.coolercontrol.enable = true;
  hardware.cpu.amd.updateMicrocode = true;

  mount = {
    media.enable = true;
    games.enable = true;
    storagebox.enable = true;
  };

  environment.systemPackages = with pkgs; [
    lm_sensors
    heroic
  ];

  services.nfs.server = {
    enable = true;
    exports = ''
      /mnt/jelly 192.168.0.0/24(ro,no_subtree_check,async)
    '';
  };

  networking.firewall.allowedTCPPorts = [ 2049 ];

}
