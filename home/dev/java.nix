{ pkgs, ... }:
let
  jdkMappings = [
    { name = "openjdk-25"; pkg = pkgs.jdk25; }
  ];
in
{
  programs.java = {
    enable = true;
    package = pkgs.jdk25;
  };
  home.sessionPath = [ "$HOME/.config/Java/jdks" ];
  home.file = builtins.listToAttrs (
    builtins.map (entry: {
      name = ".config/Java/jdks/${entry.name}";
      value = {
        source = entry.pkg;
      };
    }) jdkMappings
  );
}