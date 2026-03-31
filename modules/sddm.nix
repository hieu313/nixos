{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.workstation.sddm;
in
{
  options.workstation.sddm = {
		enable = lib.mkEnableOption "SDDM configuration";
		variant = lib.mkOption {
			type = lib.types.str;
			default = "pixel_sakura_static";
			description = "sddm-astronaut theme variant";
		};
	};

  config = lib.mkIf cfg.enable {
		environment.systemPackages = with pkgs; [
			(callPackage ../pkgs/sddm-astronaut-theme.nix { inherit (cfg) variant; })
		];

		fonts.packages = [
			(pkgs.callPackage ../pkgs/custom-fonts.nix {})
		];

		services.xserver = {
			enable = true;
			excludePackages = [ pkgs.xterm ];
		};

		services.displayManager.sddm = {
			enable = true;
			theme = "sddm-astronaut-theme";
			wayland.enable = true;
			# ref: https://github.com/NixOS/nixpkgs/pull/298345
			extraPackages = with pkgs.kdePackages; [
				qtsvg
				qtvirtualkeyboard
				qtmultimedia
			];
		};

    services.displayManager.defaultSession = "niri";
	};
}