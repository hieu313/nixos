{ pkgs, config, lib, ... }:
# TODO: install JetBrains Toolbox
# To open JetBrains IDEs, use the JetBrains Toolbox app to use latest version of IDEs
# check ~/.local/share/applications/jetbrains-toolbox.desktop, if it's exists, then remove it
let
  toolboxScripts = "${config.home.homeDirectory}/.local/share/JetBrains/Toolbox/scripts";

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

  ideList = [
    {
      name = "intellij-idea-ultimate";
      desktopName = "IntelliJ IDEA Ultimate";
      script = "idea";
      comment = "Capable and Ergonomic IDE for JVM";
      wmClass = "jetbrains-idea";
    }
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
in
{
  home.packages = [ pkgs.jetbrains-toolbox ];

  xdg.desktopEntries =
    {
      jetbrains-toolbox = {
        name = "JetBrains Toolbox";
        exec = "env JETBRAINS_CLIENT_WAYLAND=1 DISPLAY=:0 jetbrains-toolbox %U";
        icon = "jetbrains-toolbox";
        comment = "JetBrains Toolbox";
        categories = [ "Development" ];
        terminal = false;
      };
    }
    // builtins.listToAttrs (map mkJetbrainsEntry ideList);
}