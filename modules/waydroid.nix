{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.workstation.waydroid;
in
{
  options.workstation.waydroid.enable = lib.mkEnableOption "Enable Waydroid support";

  config = lib.mkIf cfg.enable {
    virtualisation.waydroid = {
			enable = true;
			package = pkgs.waydroid-nftables;
		};
		boot.kernel.sysctl = {
			"net.ipv4.ip_forward" = 1;
			"net.ipv4.conf.all.forwarding" = 1;
			"net.ipv6.conf.all.forwarding" = 1;
		};
  };
}
