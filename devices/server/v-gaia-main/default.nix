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
    ./disk-config.nix
    ./newt.nix
    ./kavita.nix
    ./backup.nix
    ../../../modules/nixvim.nix
  ];

  age.identityPaths = [ "/home/gumbo/.ssh/id_ed25519" ];

  users.users.gumbo = {
    isNormalUser = true;
    shell = pkgs.zsh;
    initialPassword = "supersecretpassword";
    extraGroups = [
      "wheel"
      "docker"
      "networkmanager"
      "sound"
      "video"
      "audio"
      "borg"
    ];
  };

  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
    device = "nodev";
  };

  networking.hostName = "v-gaia-main";

  server.baseline.enable = true;

  workstation = {
    ssh.enable = true;
    nixvim.enable = true;
  };

}
