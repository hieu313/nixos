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
    ];
  };

  fileSystems."/mnt/games" = {
    device = "/dev/disk/by-uuid/815056fa-6b7d-401a-8607-8fa22a98089b";
    fsType = "ext4";
    options = [
      "nosuid"
      "nodev"
      "noatime"
    ];
  };

  environment.systemPackages = with pkgs; [
    lm_sensors
    pciutils
    heroic
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
