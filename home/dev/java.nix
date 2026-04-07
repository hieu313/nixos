{ pkgs, ... }:

let
  # Define the list of JDK versions that will be exposed under ~/.jdks
  jdkMappings = [
		# name: the name of the JDK to be used in the environment
		# pkg: the package to be used for the JDK (https://search.nixos.org/packages?channel=25.11&query=jdk)
    { name = "openjdk-25"; pkg = pkgs.jdk25; }
  ];
in
{
  programs.java = {
    enable = true;
    # Set the default JDK used by the environment (java --version will show the version of this JDK)
		# just change the package to the JDK you want to use
    package = pkgs.jdk25;
  };

  home.sessionPath = [ "$HOME/.jdks" ];

  # Create files/symlinks under ~/.jdks for each JDK defined above
  # Result:
  #   ~/.jdks/openjdk-25 -> pkgs.jdk25_headless
  home.file = builtins.listToAttrs (
    builtins.map (entry: {
      name = ".jdks/${entry.name}";
      value = {
        source = entry.pkg;
      };
    }) jdkMappings
  );
}
