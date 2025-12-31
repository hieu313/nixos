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
    # ./containers.nix
  ];

  # Hostname
  networking.hostName = "erebos";

  # Erebos tweaks
  fileSystems."/mnt/jelly" = {
    device = "/dev/disk/by-uuid/a432d1c8-ec19-4700-8203-ec7530a6c81a";
    fsType = "ext4";
    options = [
      "nosuid"
      "nodev"
      "noatime"
      "nofail"
    ];
  };

  fileSystems."/mnt/games" = {
    device = "/dev/disk/by-uuid/7b2f5538-ff2f-44a7-9a7e-105bf75d6c70";
    fsType = "ext4";
    options = [
      "nosuid"
      "nodev"
      "noatime"
      "nofail"
    ];
  };

  environment.systemPackages = with pkgs; [
    lm_sensors
    pciutils
    heroic
    usbutils
    smartmontools
  ];

  services.nfs.server = {
    enable = true;
    exports = ''
      /mnt/jelly 192.168.0.0/24(ro,no_subtree_check,async)
    '';
  };

  programs.steam.enable = true;
  programs.coolercontrol.enable = true;
  hardware.cpu.amd.updateMicrocode = true;

  networking.firewall.allowedTCPPorts = [ 2049 ];

}
