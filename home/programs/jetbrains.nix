{ pkgs, config, lib, ... }:
# TODO: install JetBrains Toolbox
# To open JetBrains IDEs, use the JetBrains Toolbox app to use latest version of IDEs
# check ~/.local/share/applications/jetbrains-toolbox.desktop, if it's exists, then remove it
let
  toolboxScripts = "${config.home.homeDirectory}/.local/share/JetBrains/Toolbox/scripts";
	enableCustomDesktopEntries = true;

  mkJetbrainsEntry = { name, desktopName, script, comment, wmClass, categories ? [ "Development" "IDE" ] }: {
    inherit name;
    value = {
      inherit comment categories;
      name = desktopName;
      exec = "${pkgs.bash}/bin/bash ${toolboxScripts}/${script} %F";
      icon = script;
      terminal = false;
      mimeType = [ "text/plain" "inode/directory" ];
      settings = {
        StartupWMClass = wmClass;
        StartupNotify = "true";
      };
    };
  };

	# TODO: Toolbox automatically creates desktop entries for the installed IDEs, but sometimes it doesn't work
	# so we need to create custom desktop entries for the installed IDEs
	# If you use custom desktop entries, you need to set enableCustomDesktopEntries to true in the configuration
	# and remove .desktop files which created by Toolbox in ~/.local/share/applications
  ideList = [
    # {
    #   name = "intellij-idea-ultimate";
    #   desktopName = "IntelliJ IDEA Ultimate";
    #   script = "idea";
    #   comment = "Capable and Ergonomic IDE for JVM";
    #   wmClass = "jetbrains-idea";
    # }
    # {
    #   name = "goland";
    #   desktopName = "GoLand";
    #   script = "goland";
    #   comment = "Go IDE by JetBrains";
    #   wmClass = "jetbrains-goland";
    # }
    # {
    #   name = "webstorm";
    #   desktopName = "WebStorm";
    #   script = "webstorm";
    #   comment = "JavaScript and TypeScript IDE";
    #   wmClass = "jetbrains-webstorm";
    # }
    # {
    #   name = "datagrip";
    #   desktopName = "DataGrip";
    #   script = "datagrip";
    #   comment = "Database IDE by JetBrains";
    #   wmClass = "jetbrains-datagrip";
    # }
  ];

	allDesktopEntries = {
		jetbrains-toolbox = {
			name = "JetBrains Toolbox";
			exec = "env JETBRAINS_CLIENT_WAYLAND=1 DISPLAY=:0 ${pkgs.jetbrains-toolbox}/bin/jetbrains-toolbox %U";
			icon = "jetbrains-toolbox";
			comment = "JetBrains Toolbox";
			categories = [ "Development" ];
		};
	} // builtins.listToAttrs (map mkJetbrainsEntry ideList);
in
{
  home.packages = [ pkgs.jetbrains-toolbox ];

  xdg.desktopEntries = lib.mkIf enableCustomDesktopEntries allDesktopEntries;
}