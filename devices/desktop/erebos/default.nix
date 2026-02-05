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
    ../../../modules/niri.nix #     <-- niri environment
    # ../../../modules/hypr.nix     <-- hyprland environment
    # ../../../modules/gnome.nix    <-- gnome environemt
    # ../../../modules/kde.nix      <-- kde environment
    # ../../../modules/xfce.nix     <-- xfce environment
    ../../../modules/storagebox.nix
    ../../../modules/games-disk.nix
    ../../../modules/media-disk.nix
    ../../../modules/ssh.nix
    ../../../modules/nixvim.nix
    ../../../modules/yazi.nix
    ../../../modules/virtualization.nix
  ];

  # hostname
  networking.hostName = "erebos";

  workstation = {
    baseline.enable = true;       # enable workstation baseline module
    nixvim.enable = true;         # enable nixvim configuration
    niri.enable = true;           # change to a different profile if you want
    yazi.enable = true;           # yazi
    ssh.enable = true;            # enable default ssh configuration + authorized yubikeys
    virtualization.enable = true; # enable QEMU/KVM virtualization
  };

  # environments, switch to true or false as needed
  # workstation.hypr.enable = true;
  # workstation.gnome.enable = true;
  # workstation.kde.enable = true;
  # workstation.xfce.enable = true;

  mount = {
    media.enable = true;
    games.enable = true;
  };

  services.nfs.server = {
    enable = true;
    exports = ''
      /mnt/jelly/jelly  192.168.0.0/24(ro,no_subtree_check,async)
      /mnt/jelly/manga  192.168.0.0/24(ro,no_subtree_check,async)
      /mnt/jelly/photos 192.168.0.0/24(rw,no_subtree_check,sync)
      /mnt/jelly/music  192.168.0.0/24(rw,no_subtree_check,async)
    '';
  };
  
  programs.steam.enable = true;
  programs.coolercontrol.enable = true;
  hardware.cpu.amd.updateMicrocode = true;

  environment.systemPackages = with pkgs; [
    lm_sensors
    heroic
    picard
    terraform
  ];

  networking.firewall.allowedTCPPorts = [ 2049 ];

}
