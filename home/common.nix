{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./packages.nix
    ./flatpak.nix
    ./config-files.nix
  ];

  home = {
    username = "hieunm";
    homeDirectory = "/home/hieunm";
    stateVersion = "25.05";
  };

  programs.home-manager.enable = true;
  programs.git = {
      enable = true;
      package = pkgs.git;
      settings = {
          core.editor = "nvim";
      };
  };

	programs.kitty = {
		enable = true;
	};

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "tokyo-night";
      theme_background = true;
      truecolor = true;
    };
  };


  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };
}
