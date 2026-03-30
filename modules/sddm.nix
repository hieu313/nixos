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
  options.workstation.sddm.enable =
    lib.mkEnableOption "SDDM configuration";

  config = lib.mkIf cfg.enable {
		environment.systemPackages = with pkgs; [
			(callPackage ../pkgs/sddm-astronaut-theme.nix {})
		];

		# Qt6 packages required at runtime for sddm-astronaut-theme
		# ref: https://github.com/NixOS/nixpkgs/pull/298345
		services.displayManager.sddm.extraPackages = with pkgs.kdePackages; [
			qtsvg
			qtvirtualkeyboard
			qtmultimedia
		];

		fonts.packages = [
			(pkgs.callPackage ../pkgs/custom-fonts.nix {})
		];

		services.displayManager.sddm = {
			enable = true;
			theme = "sddm-astronaut-theme";
			wayland.enable = true;
		};
	};
}