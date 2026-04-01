{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.workstation.niri;
	sddmCfg = config.workstation.sddm;
in
{
  options.workstation.niri.enable = lib.mkEnableOption "Niri-based workstation environment with Noctalia Shell";

  config = lib.mkIf cfg.enable {
    programs.niri.enable = true;

    qt = {
      enable = true;
    };

		environment.variables = {
      GTK_USE_PORTAL = "1";
			NIXOS_OZONE_WL = "1";
			XDG_SESSION_TYPE = "wayland";
			XDG_CURRENT_DESKTOP = "niri";
		};

    environment.systemPackages = with pkgs; [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      xwayland-satellite
      tokyonight-gtk-theme
      swayimg
      rose-pine-cursor
      papirus-icon-theme
      nemo
      fuzzel
      gpu-screen-recorder
      wl-clipboard
      libsForQt5.qt5ct
			kdePackages.qt6ct
      mpvpaper
    ];
  };
}
