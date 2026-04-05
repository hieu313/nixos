{ pkgs, config, lib, ... }:
# TODO: install JetBrains Toolbox
# To open JetBrains IDEs, use the JetBrains Toolbox app to use latest version of IDEs
# check ~/.local/share/applications/jetbrains-toolbox.desktop,  if it's exists, then remove it	
{
  home.packages = [ pkgs.jetbrains-toolbox ];

	xdg.desktopEntries.jetbrains-toolbox = {
		name = "JetBrains Toolbox";
		exec = "env JETBRAINS_CLIENT_WAYLAND=1 DISPLAY=:0 jetbrains-toolbox %U";
		icon = "jetbrains-toolbox";
		comment = "JetBrains Toolbox";
		categories = [ "Development" ];
		terminal = false;
	};
}